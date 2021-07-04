#include "../Socket.h"

void DealError()
{
    printf("errInfo: [%s][%d] \n", strerror(errno), errno);
}

int main()
{
    int socket_fd, connect_fd;
    struct sockaddr_in servaddr;
    char buff[4096];
    int n;

    // 构造socker对象
    if ((socket_fd = socket(AF_INET, SOCK_STREAM, 0)) = -1)
    {
        printf("create socker fail ");
        DealError();
        return 0;
    }

    memset(&servaddr, 0, sizeof(sockaddr_in));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY); // IP地址设置成INADDR_ANY，表示系统自动获取本机IP
    servaddr.sin_port = htons(8000);

    if (bind(socket_fd, (struct sockaddr*)&servaddr, sizeof(servaddr)) == - 1)
    {
        printf("bind socket fail ");
        DealError();
        return 0;
    }

    return 0;
}