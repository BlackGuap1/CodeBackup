
message("now using Findprotobuf.cmake find protobuf lib")

if (MSVC)
FIND_PATH(PROTOBUF_INCLUDE_DIR google/protobuf/message.h ${PATH3RD}/protobuf/include)
message("./h dir ${PROTOBUF_INCLUDE_DIR}")		

if(CMAKE_CL_64)    #CMAKE的内建变量，如果是true，就说明编译器的64位的，自然可以编译64bit的程序
		FIND_LIBRARY(PROTOBUF_LIBRARY_D libprotobufd.lib ${PATH3RD}/protobuf/lib64)
		FIND_LIBRARY(PROTOBUF_LIBRARY libprotobuf.lib ${PATH3RD}/protobuf/lib64)
		message("lib dir: ${PROTOBUF_LIBRARY}")
	else()
		FIND_LIBRARY(PROTOBUF_LIBRARY_D libprotobufd.lib ${PATH3RD}/protobuf/lib)
		FIND_LIBRARY(PROTOBUF_LIBRARY libprotobuf.lib ${PATH3RD}/protobuf/lib)
		message("lib dir: ${PROTOBUF_LIBRARY}")
	endif()


else (MSVC)
	#Linux
	FIND_PATH(PROTOBUF_INCLUDE_DIR google/protobuf/message.h ${PATH3RD}/include)
	message("protobuf ./h dir ${PROTOBUF_INCLUDE_DIR}")
	
if(DYNAMIC_BUILD)
	FIND_LIBRARY(PROTOBUF_LIBRARY  protobuf ${PATH3RD}/lib)
	message("protobuf lib dir: ${PROTOBUF_LIBRARY}")
else(DYNAMIC_BUILD)
	FIND_LIBRARY(PROTOBUF_LIBRARY  libprotobuf.a ${PATH3RD}/lib)
	message("protobuf lib dir: ${PROTOBUF_LIBRARY}")
endif (DYNAMIC_BUILD)

endif (MSVC)


if(PROTOBUF_INCLUDE_DIR AND PROTOBUF_LIBRARY)
    # 设置变量结果
    set(PROTOBUF_FOUND TRUE)
endif(PROTOBUF_INCLUDE_DIR AND PROTOBUF_LIBRARY)