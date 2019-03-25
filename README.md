# is-windows-server

[![Build Status](https://dev.azure.com/mark-tiedemann/is-windows-server/_apis/build/status/MarkTiedemann.is-windows-server)](https://dev.azure.com/mark-tiedemann/is-windows-server/_build)

**Check whether you are running on a Windows server or client.**

## Installation

```sh
# TODO: Setup CI and publish package on npm
npm install is-windows-server
```

## Quickstart

```js
var isServer = require("is-windows-server");

// On a Windows server
isServer; // => true

// On a Windows client
isServer; // => false

// On Linux or Mac
isServer; // => false

// If the detection failed
isServer; // => null
```

## Features

- Tested on Node v4-11 (x64, ia32)
- Uses prebuilt N-API modules (v1-4) for optimal performance
- Multiple fallbacks to `reg` and `wmic` queries

## Development

```batch
make
make test
make clean
```

## License

MIT
