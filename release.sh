
# Do some cleanup
rm -rf ../solfege-release

mkdir game
cp -R * game
cd ./game
rm -rf game
rm -rf examples
rm -rf spec
rm -rf .git
rm -rf .vscode
sed -i -e '/--- BEGIN DEBUG/,/--- END DEBUG/d' main.lua
rm lib/debugGraph.lua
rm lib/lurker.lua

rm release.sh
# Make the releases
love-release -W32 -W64 -D -M ../../solfege-release .

# Cleanup self
cd ..
rm -rf game
