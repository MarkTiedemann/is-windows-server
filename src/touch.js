var fs = require("fs");
var now = new Date();
fs.utimesSync(process.argv[1], now, now);
