# is-windows-server-node-native-addon

**Node native addon to check whether you are running on a Windows server or desktop.**

## Installation

```batch
:: TODO: Publish package on NPM
npm install is-windows-server-node-native-addon
```

## Quickstart

```js
const isWindowsServer = require("is-windows-server-node-native-addon");

// On a Windows Server
isWindowsServer; // => true

// On a Windows Desktop
isWindowsServer; // => false
```

## Compatibility

- Node versions: `6`, `8-11+`
- Node arch: `ia32`, `x64`
- N-API versions: `1-4+`

## Development

```batch
make
make test
make clean
```

## License

MIT
