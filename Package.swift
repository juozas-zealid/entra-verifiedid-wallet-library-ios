// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "WalletLibrary",
    platforms: [
        .iOS(.v13) // Matches ios.deployment_target = '13.0'
    ],
    products: [
        .library(
            name: "WalletLibrary",
            targets: ["WalletLibrary"] // Public product includes Core functionality
        )
    ],
    targets: [
        // Secp256k1 target (C-based library)
        .target(
            name: "Secp256k1",
            path: "WalletLibrary/Submodules/VerifiableCredential-SDK-iOS/Submodules/Secp256k1/bitcoin-core/secp256k1",
            exclude: [
                "src/bench.c",
                "src/bench_ecdh.c",
                "src/bench_ecmult.c",
                "src/bench_internal.c",
                "src/bench_recover.c",
                "src/bench_schnorrsig.c",
                "src/bench_sign.c",
                "src/bench_verify.c",
                "src/tests.c",
                "src/testrand_impl.h",
                "src/testrand.h",
                "src/valgrind_ctime_test.c",
                "src/ctime_tests.c",
                "src/gen_context.c",
                "src/precompute_ecmult.c",
                "src/precompute_ecmult_gen.c",
                "src/tests_exhaustive.c",
                "contrib"
            ],
            sources: [
                "include",
                "src"
            ],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
                .define("ECMULT_WINDOW_SIZE", to: "15"),
                .define("USE_NUM_NONE", to: "1"),
                .define("ECMULT_GEN_PREC_BITS", to: "4"),
                .define("USE_FIELD_INV_BUILTIN", to: "1"),
                .define("USE_SCALAR_INV_BUILTIN", to: "1"),
                .define("HAVE_DLFCN_H", to: "1"),
                .define("HAVE_INTTYPES_H", to: "1"),
                .define("HAVE_MEMORY_H", to: "1"),
                .define("HAVE_STDINT_H", to: "1"),
                .define("HAVE_STDLIB_H", to: "1"),
                .define("HAVE_STRINGS_H", to: "1"),
                .define("HAVE_STRING_H", to: "1"),
                .define("HAVE_SYS_STAT_H", to: "1"),
                .define("HAVE_SYS_TYPES_H", to: "1"),
                .define("HAVE_UNISTD_H", to: "1"),
                .define("LT_OBJDIR", to: "\".libs/\""),
                .define("PACKAGE", to: "\"libsecp256k1\""),
                .define("PACKAGE_BUGREPORT", to: "\"\""),
                .define("PACKAGE_NAME", to: "\"libsecp256k1\""),
                .define("PACKAGE_STRING", to: "\"libsecp256k1 0.1\""),
                .define("PACKAGE_TARNAME", to: "\"libsecp256k1\""),
                .define("PACKAGE_URL", to: "\"\""),
                .define("PACKAGE_VERSION", to: "\"0.1\""),
                .define("STDC_HEADERS", to: "1"),
                .define("VERSION", to: "\"0.1\""),
                .unsafeFlags(["-Wno-shorten-64-to-32", "-Wno-unused-function"])
            ]
        ),
        
        // Core target (Swift-based library)
        .target(
            name: "WalletLibrary",
            dependencies: ["Secp256k1"],
            path: "WalletLibrary",
            exclude: [
                "WalletLibrary/**/*Test/*.swift" // Exclude test files
            ],
            sources: [
                "WalletLibrary", // Main Swift files
                "Submodules/VerifiableCredential-SDK-iOS/VCServices/VCServices",
                "Submodules/VerifiableCredential-SDK-iOS/VCNetworking/VCNetworking",
                "Submodules/VerifiableCredential-SDK-iOS/VCEntities/VCEntities",
                "Submodules/VerifiableCredential-SDK-iOS/VCToken/VCToken",
                "Submodules/VerifiableCredential-SDK-iOS/VCCrypto/VCCrypto"
            ],
            resources: [
                .process("Submodules/VerifiableCredential-SDK-iOS/VCServices/VCServices/Resources")
            ],
            swiftSettings: [
                .define("SWIFT_VERSION", to: "5.0")
            ]
        )
    ],
    swiftLanguageVersions: [.v5] // Matches swift_version = '5.0'
)
