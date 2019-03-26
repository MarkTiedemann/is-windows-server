"use strict";

module.exports = isWindowsServer();

function isWindowsServer() {
  if (process.platform != "win32") return false;

  var isServer = determineViaNativeAddon();
  if (isServer != null) return isServer;

  isServer = determineViaRegistry();
  if (isServer != null) return isServer;

  isServer = determineViaManagementInstrumentation();
  if (isServer != null) return isServer;

  return isServer;
}

function determineViaNativeAddon() {
  var napiVersion = getNapiVersion();
  if (napiVersion == null) return null;

  var addon = "addon_napi_v" + napiVersion + "_" + process.arch + ".node";
  var mod = { exports: { isServer: null } };

  try {
    process.dlopen(mod, __dirname + "\\src\\" + addon);
  } catch (e) {
    return null;
  }

  return mod.exports.isServer;
}

function determineViaRegistry() {
  try {
    /*
    > reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v InstallationType

    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion
        InstallationType    REG_SZ    Client

    */

    var result = require("child_process")
      .execSync('reg.exe query "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion" /v InstallationType')
      .toString("utf-8");

    var match = /InstallationType\s+REG_SZ\s+(\w+)/.exec(result);
    if (match == null) return null;

    // InstallationType could be:
    // - Client
    // - Server
    // - Nano Server
    // - Server Core
    // ...

    return match[1] != "Client";
  } catch (e) {
    return null;
  }
}

function determineViaManagementInstrumentation() {
  try {
    // https://docs.microsoft.com/en-us/windows/desktop/CIMWin32Prov/win32-operatingsystem

    /*
    > wmic path Win32_OperatingSystem get ProductType
    ProductType
    1

    */

    var result = require("child_process")
      .execSync("wmic.exe path Win32_OperatingSystem get ProductType")
      .toString("utf-8");

    var match = /ProductType\s+(\d)/.exec(result);
    if (match == null) return null;

    // ProductType will be one of:
    // - 1: Workstation
    // - 2: Domain Controller
    // - 3: Server

    return match[1] != "1";
  } catch (e) {
    return null;
  }
}

function getNapiVersion() {
  // https://nodejs.org/docs/latest/api/n-api.html#n_api_n_api_version_matrix

  // N-API 4
  // N-API 3
  var napiVersion = process.versions.napi;
  if (napiVersion != undefined) {
    napiVersion = parseInt(napiVersion);
    if (napiVersion <= 4) return napiVersion;
    else return 4; // Future version, fallback to 4
  }

  var version = /v(\d+)\.(\d+)\.(\d+)/.exec(process.version).map(function(s) {
    return parseInt(s);
  });

  var major = version[1];
  var minor = version[2];
  var patch = version[3];

  // N-API 2
  // v8.10.0 -> v8.11.2
  if (major == 8 && (minor == 10 || (minor == 11 && patch < 2))) return 2;
  // v9.3.0 -> v9.11.0
  if (major == 9 && (minor >= 3 && minor < 11)) return 2;

  // N-API 1
  // v8.0.0 -> v8.10.0
  if (major == 8 && minor < 10) return 1;
  // v9.0.0 -> v9.3.0
  if (major == 9 && minor < 3) return 1;

  return null;
}
