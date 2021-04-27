mkdir build
cd build
echo "build"
cmake .. -G "Visual Studio 14 2015 Win64"

echo "compile"
devenv EasyRpc.sln /build "Release|x64"

cd ..
