rmdir temp
mkdir temp
cp src/*.lua temp
cp images/*.png temp
cp fonts/*.ttf temp
cd temp
rm main.lua
mv main-unit-editor.lua main.lua
zip ../the-king-and-the-crown.love * 
