var path = require("path");

var napiVersion = (function() {
  // https://nodejs.org/docs/latest/api/n-api.html#n_api_n_api_version_matrix

  // N-API 4
  // N-API 3
  if (process.versions.napi) return process.versions.napi;

  var version = /v(\d+)\.(\d+)\.(\d+)/
    .exec(process.version)
    .slice(1)
    .map(function(s) {
      return parseInt(s);
    });

  var major = version[0];
  var minor = version[1];
  var patch = version[2];

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

  throw new Error("node " + process.version + " does not support N-API");
})();

var addon = "addon_napi_v" + napiVersion + "_" + process.arch + ".node";
var addonPath = path.join(__dirname, addon);

var isServer =
  process.platform == "win32" ? require(addonPath).isServer : false;

module.exports = isServer;
