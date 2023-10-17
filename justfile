ROOT_DIR := justfile_directory()

###########################################################
### Build 

# Build release
build:
    cargo build --target aarch64-apple-ios --release
    rm -rf ${ROOT_DIR}/libs/libcrypto_eth-ios.a
    cp ${ROOT_DIR}/target/aarch64-apple-ios/release/libcrypto_eth.a ${ROOT_DIR}/libs/libcrypto_eth-ios.a

# Build for simulators
build-virtual:
    cargo build --target aarch64-apple-ios-sim --release
    rm -rf ${ROOT_DIR}/libs/libcrypto_eth-ios-sim.a
    cp ${ROOT_DIR}/target/aarch64-apple-ios/release/libcrypto_eth.a ${ROOT_DIR}/libs/libcrypto_eth-ios.a
    lipo -create -output ${ROOT_DIR}/libs/libcrypto_eth-ios-sim.a \
        ${ROOT_DIR}/target/aarch64-apple-ios-sim/release/libcrypto_eth.a

# prerequirement: sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
build-xcframework:
    xcodebuild -create-xcframework \
    -library libs/libcrypto_eth-ios-sim.a \
    -headers ./include/ \
    -library libs/libcrypto_eth-ios.a \
    -headers ./include/ \
    -output CryptoEth.xcframework
###########################################################1