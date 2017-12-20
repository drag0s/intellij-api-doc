#!/bin/bash

echo "Finding packages (excluding test packages)"

PACKAGES=`find intellij-community -name *.java | grep -v "test" | grep -v "\.idea" | xargs -n 1 -I '{}' grep -E "^package.*;$" '{}' | sed -Ee "s/^package ([^;]*);$/\1/g" | sort | uniq | paste -s -d ":" - 2>/dev/null` 

echo "Finding source paths"

SRCPATH=`find intellij-community -name src | paste -s -d ":" - 2>/dev/null`

echo "Cleaning docs"

rm -rf docs &>/dev/null

echo "Generating JavaDoc"

javadoc -quiet -d docs -doctitle '<h1>Unofficial IntelliJ Community Edition API documentation</h1>' -windowtitle 'Unofficial IntelliJ Community Edition API docs' -footer '<p>This is <b>unofficial</b> documentation and <b>not affiliated with Jetbrains s.r.o.</b> at all. We can <b>not guarantee the correctness</b> of this documentation.</p>' -sourcepath ${SRCPATH} -subpackages ${PACKAGES} 

# ignore javadoc errors

exit 0
