#!/usr/bin/bash

name="$1"
dir="ftcmaven_scraped_11.1.0"

echo "Combining \"$name\""

cd "$dir"

if [ ! \( -d "$name-aar" -a -d "$name-sources" \) ] ; then
   echo "Source directories not found";
   exit 1
fi

if [ -d "$name-combined" ] ; then
   echo "Already Combined";
else
    mkdir "$name-combined"
    cd $name-combined

    cp -r ../$name-aar/libs .
    mkdir -p src/main
    cp -r ../$name-aar/assets src/main/
    cp -r ../$name-aar/res src/main/
    cp -r ../$name-aar/AndroidManifest.xml src/main/
    cp -r ../$name-sources src/main/java
    rm -r src/main/java/META-INF

    cd ..
fi

cd ..

diff --exclude=build.gradle --exclude=.gitignore -r "$dir/$name-combined" "$name"
