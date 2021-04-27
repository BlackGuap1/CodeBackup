
message("now using FindHpSocket.cmake find HpSocket lib")


FIND_PATH(HPSOCKET_INCLUDE_DIR HPSocket/HPSocket.h ${PATH3RD}/hpsocket/include)
message("./h dir ${HPSOCKET_INCLUDE_DIR}")		

 if(CMAKE_CL_64)    #CMAKE的内建变量，如果是true，就说明编译器的64位的，自然可以编译64bit的程序
	FIND_LIBRARY(HPSOCKET_LIBRARY_D HPSocket_D.lib ${PATH3RD}/HPSocket/lib64)
	FIND_LIBRARY(HPSOCKET_LIBRARY HPSocket.lib ${PATH3RD}/HPSocket/lib64)
	message("lib dir: ${HPSOCKET_LIBRARY}")
else()
	FIND_LIBRARY(HPSOCKET_LIBRARY_D HPSocket_D.lib ${PATH3RD}/HPSocket/lib)
	FIND_LIBRARY(HPSOCKET_LIBRARY HPSocket.lib ${PATH3RD}/HPSocket/lib)
	message("lib dir: ${HPSOCKET_LIBRARY}")
endif()



if(HPSOCKET_INCLUDE_DIR AND HPSOCKET_LIBRARY)
    # 设置变量结果
    set(HPSOCKET_FOUND TRUE)
endif(HPSOCKET_INCLUDE_DIR AND HPSOCKET_LIBRARY)