var isWindowsServer = require("./index.js");
console.log(isWindowsServer);
process.exitCode = isWindowsServer !== null ? 0 : 1;
