MKDIR temp
COPY src\*.* temp
COPY images\*.* temp

del temp\main.lua
del temp\main-level-editor.lua
COPY temp\main-tileset-editor.lua temp\main.lua

cd ..
love.exe the-king-and-the-crown\temp
RMDIR the-king-and-the-crown\temp
