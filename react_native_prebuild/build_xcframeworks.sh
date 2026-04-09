#!/bin/bash
set -euo pipefail
export SRCROOT=$(pwd)
export WORKSPACE=ReactNativePrebuild
export PROJECT="Pods-$WORKSPACE"

function archive() {
  xcodebuild archive \
    -workspace $WORKSPACE.xcworkspace \
    -scheme $PROJECT \
    -archivePath $SRCROOT/$PROJECT-iphonesimulator.xcarchive \
    -configuration $1 \
    -sdk iphonesimulator \
    -quiet \
    SKIP_INSTALL=NO
  xcodebuild archive \
    -workspace $WORKSPACE.xcworkspace \
    -scheme $PROJECT \
    -archivePath $SRCROOT/$PROJECT-iphoneos.xcarchive \
    -configuration $1 \
    -sdk iphoneos \
    -quiet \
    SKIP_INSTALL=NO
}

function create_xcframework() {
    for framework in $(find $SRCROOT/$PROJECT-iphonesimulator.xcarchive/Products/Library/Frameworks -type d -name "*.framework");
    do
        basename=$(basename $framework)
        framework_name=$(basename $framework .framework)

        xcodebuild -create-xcframework \
            -framework "$SRCROOT/$PROJECT-iphonesimulator.xcarchive/Products/Library/Frameworks/$basename" \
            -framework "$SRCROOT/$PROJECT-iphoneos.xcarchive/Products/Library/Frameworks/$basename" \
            -output "$SRCROOT/Frameworks/$framework_name.xcframework"
    done

    copyCommonFramworks
}

function copyCommonFramworks() {
  cp -R $SRCROOT/Pods/hermes-engine/destroot/Library/Frameworks/universal/hermes.xcframework $SRCROOT/Frameworks/hermes.xcframework
}

function clean() {
    rm -rf $SRCROOT/$PROJECT-iphoneos.xcarchive
    rm -rf $SRCROOT/$PROJECT-iphonesimulator.xcarchive
    rm -rf Pods
    rm -rf node_modules
}

function build_and_create_frameworks() {
    local configuration="Release"
    rm -rf build
    npm install -g pnpm
    pnpm install
    pod install
    archive $configuration
    create_xcframework
    clean
}

function initDirectory() {
    rm -rf $SRCROOT/Frameworks
    rm -rf $SRCROOT/Sources
    mkdir -p $SRCROOT/Frameworks
    mkdir -p Sources
    touch Sources/dummy.swift
}

initDirectory
build_and_create_frameworks
ruby ./generate_package_swift.rb
