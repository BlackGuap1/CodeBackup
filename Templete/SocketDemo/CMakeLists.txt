PROJECT(socket_demo)

CMAKE_MINIMUM_REQUIRED(VERSION 3.20)

INCLUDE_DIRECTORIES($(PROJECT_BINARY_DIR)/include)


add_definitions(-std=c++11)

add_subdirectory(Provider)
add_subdirectory(Caller)
