#!/usr/bin/env bash

case $ANDROID_ABI in
  x86)
    target="android-x86"
    ;;
  x86_64)
    target="android-x86_64"
    ;;
  armeabi-v7a)
    target="android-arm"
    ;;
  arm64-v8a)
    target="android-arm64"
    ;;
esac

export ANDROID_NDK_ROOT=${ANDROID_NDK_HOME}
export PATH=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin:$ANDROID_NDK_HOME/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin:$ANDROID_NDK_HOME/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/bin:$PATH

echo "${INSTALL_DIR} | ${TARGET}"

./Configure \
    --prefix=${INSTALL_DIR} \
    ${target} \
    no-shared \
    -D__ANDROID_API__=${ANDROID_PLATFORM} \
    CC=${FAM_CC} \
    AR=${FAM_AR} \
    RANLIB=${FAM_RANLIB} || exit 1

export FFMPEG_EXTRA_LD_FLAGS="${FFMPEG_EXTRA_LD_FLAGS} -lm"

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install
