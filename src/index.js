// module.exports = require(`./addon_napi_v${process.versions.napi}_${process.arch}.node`).isServer
module.exports = require(`./addon_${process.arch}.node`).isServer
