#google protobuf 
#第一步将proto结构文件生成C++代码
#第二步将C++代码生成proto库
include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
)


set(PROC_PATH ${CMAKE_CURRENT_SOURCE_DIR})


message("protoc : ${PROC_PATH}/protoc --proto_path=${CMAKE_CURRENT_SOURCE_DIR} --cpp_out=${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/Authentication.proto")

add_custom_command (
  OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/Authentication.pb.cc
  COMMAND ${PROC_PATH}/protoc --proto_path=${CMAKE_CURRENT_SOURCE_DIR} --cpp_out=${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/Authentication.proto
  )
  


# 生成链接库(使用静态库)
add_library(proto STATIC ${CMAKE_CURRENT_SOURCE_DIR}/Authentication.pb.cc ${CMAKE_CURRENT_SOURCE_DIR}/Authentication.proto)

install (TARGETS proto DESTINATION lib)