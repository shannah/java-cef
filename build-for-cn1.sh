#!/bin/sh
# Based on build instructions at https://bitbucket.org/chromiumembedded/java-cef/wiki/BranchesAndBuilding
# Based on bundle structure described here https://bitbucket.org/chromiumembedded/java-cef/issues/109/linux-mac-fix-discovery-of-icudtldat

set -e
if [ ! -d jcef_build ]; then
	mkdir jcef_build
fi
cd jcef_build
cmake -G "Xcode" -DPROJECT_ARCH="x86_64" ..

if [ "$1" == "clean" ]; then
	xcodebuild -project jcef.xcodeproj -configuration Release clean
fi
xcodebuild -project jcef.xcodeproj -configuration Release
cd native/Release
CEFROOT=~/.codenameone/cef
if [ -d $CEFROOT ]; then
	echo "$CEFROOT already exists.\n"
	exit 1
fi

mkdir $CEFROOT
if [ ! -d $CEFROOT/macos64 ]; then
	mkdir $CEFROOT/macos64; 
fi
cp -r "jcef_app.app/Contents/Frameworks/Chromium Embedded Framework.framework" $CEFROOT/macos64/
cp -r "jcef Helper.app" $CEFROOT/macos64/
cp -r "jcef Helper (GPU).app" $CEFROOT/macos64/
cp -r "jcef Helper (Plugin).app" $CEFROOT/macos64/
cp -r "jcef Helper (Renderer).app" $CEFROOT/macos64/
cp *.dylib $CEFROOT/macos64/
cp *.jar $CEFROOT/

