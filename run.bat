MKDIR temp
COPY src\*.* temp
COPY images\*.* temp
COPY fonts\*.* temp

REM del temp\main.lua
REM COPY temp\main2.lua temp\main.lua

cd ..
love.exe the-king-and-the-crown\temp
RMDIR the-king-and-the-crown\temp
