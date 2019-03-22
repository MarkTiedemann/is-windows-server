switch (process.arch) {
  case "x64": return console.log(require('./addon_x64.node'))
  case "ia32": return console.log(require('./addon_ia32.node'))
  default: throw new Error(`unsupported architecture '${process.arch}'`)
}
