# ifndef SOCKET_H_
# define SOCKET_H_

#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
// linux调用系统api调用失败错误信息读取 errno.h
#include <errno.h>
// #include <iostream>
#include <string>

#define MAXLINE 4096

void DealError(const char* str)
{
    printf("%s, errInfo: [%s][%d] \n", str, strerror(errno), errno);
}

#endif /* SOCKET_H_ */