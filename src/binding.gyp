{
    "targets": [
        {
            "target_name": "addon_napi_v3",
            "cflags!": ["-fno-exceptions"],
            "cflags_cc!": ["-fno-exceptions"],
            "sources": ["addon.cc"],
            "include_dirs": ["..\\tools\\node-addon-api"],
            "defines": [
                "NAPI_VERSION=3",
                "NAPI_DISABLE_CPP_EXCEPTIONS"
            ],
        },
        {
            "target_name": "addon_napi_v4",
            "cflags!": ["-fno-exceptions"],
            "cflags_cc!": ["-fno-exceptions"],
            "sources": ["addon.cc"],
            "include_dirs": ["..\\tools\\node-addon-api"],
            "defines": [
                "NAPI_VERSION=4",
                "NAPI_DISABLE_CPP_EXCEPTIONS"
            ],
        }
    ]
}
