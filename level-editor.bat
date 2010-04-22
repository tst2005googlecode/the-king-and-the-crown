MKDIR temp
COPY src\*.* temp
COPY images\*.* temp

del temp\main.lua
COPY temp\main-level-editor.lua temp\main.lua

cd ..
love.exe the-king-and-the-crown\temp
RMDIR the-king-and-the-crown\temp
