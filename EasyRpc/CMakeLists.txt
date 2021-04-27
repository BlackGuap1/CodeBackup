cmake_minimum_required (VERSION 2.8)
project(EasyRpc)


if (NOT MSVC)
#set(CFLAGS "-m64")
#添加c++17支持
add_definitions(-std=c++17)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m64 -std=c++17 -pthread -ldl ")
else (NOT MSVC)
#添加c++11支持
add_definitions(-std=c++11)
add_definitions(-D WIN32_LEAN_AND_MEAN)
endif (NOT MSVC)

set(CMAKE_INSTALL_PREFIX "./")

#设置第三方库根目录
if(MSVC)
	set(PATH3RD $ENV{Path3rd})
else(MSVC)
	set(PATH3RD "$ENV{HOME}/local")
endif(MSVC)

if(MSVC)     
    # Use the static C library for all build types
    foreach(var 
        CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
        CMAKE_C_FLAGS_MINSIZEREL CMAKE_C_FLAGS_RELWITHDEBINFO
        CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
        CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO
      )
      if(${var} MATCHES "/MD")
        string(REGEX REPLACE "/MD" "/MT" ${var} "${${var}}")
      endif()
    endforeach()    
endif(MSVC)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
message("cmake path ${CMAKE_MODULE_PATH}")

LINK_DIRECTORIES(${PATH3RD}/lib)
include_directories(${PATH3RD})

########################################################################
# protobuf dependency
########################################################################
find_package(protobuf)
IF (PROTOBUF_FOUND)
    include_directories(${PROTOBUF_INCLUDE_DIR})
ELSE (PROTOBUF_FOUND)
    message( FATAL_ERROR "PROTOBUF_FOUND not found." )
ENDIF (PROTOBUF_FOUND)

########################################################################
# HpSocket dependency
########################################################################
find_package(HpSocket)
IF (HPSOCKET_FOUND)
    include_directories(${HPSOCKET_INCLUDE_DIR})
ELSE (HPSOCKET_FOUND)
    message( FATAL_ERROR "HPSOCKET_FOUND not found." )
ENDIF (HPSOCKET_FOUND)

add_subdirectory(proto)

add_subdirectory(EasyRpcClient)

add_subdirectory(EasyRpcServer)
