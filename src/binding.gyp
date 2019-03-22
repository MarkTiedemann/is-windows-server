{
    "targets": [
        {
            "target_name": "addon",
            "cflags!": ["-fno-exceptions"],
            "cflags_cc!": ["-fno-exceptions"],
            "sources": ["addon.cc"],
            "include_dirs": ["..\\tools\\node-addon-api"],
            "defines": ["NAPI_DISABLE_CPP_EXCEPTIONS"],
        }
    ]
}
