process.exitCode = require("./") === Boolean(process.env.CI) ? 0 : 1;
