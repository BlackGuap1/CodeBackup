include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
	${PROJECT_SOURCE_DIR}
)
message("${PROJECT_SOURCE_DIR}")

aux_source_directory(. DIR_SRCS)
	
file(GLOB HEAD_FILE_LIST *.h)


# 生成exe
add_executable(EasyRpcClient ${DIR_SRCS} ${HEAD_FILE_LIST})

set_target_properties(EasyRpcClient PROPERTIES
		  COMPILE_FLAGS "/DHPSOCKET_STATIC_LIB")


target_link_libraries(EasyRpcClient proto)
target_link_libraries(EasyRpcClient debug ${HPSOCKET_LIBRARY_D} optimized ${HPSOCKET_LIBRARY})
target_link_libraries(EasyRpcClient debug ${PROTOBUF_LIBRARY_D} optimized ${PROTOBUF_LIBRARY})