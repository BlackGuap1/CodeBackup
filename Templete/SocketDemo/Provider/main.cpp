#include "../Socket.h"
#define MAXLINE 4096
void DealError(const char* str)
{
    printf("%s, errInfo: [%s][%d] \n", str, strerror(errno), errno);
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
        std::string s = "creat socket fail";
        DealError(s.c_str());
        return 0;
    }

    memset(&servaddr, 0, sizeof(sockaddr_in));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY); // IP地址设置成INADDR_ANY，表示系统自动获取本机IP
    servaddr.sin_port = htons(8000);

    // 将socket绑定到某个端口
    if (bind(socket_fd, (struct sockaddr*)&servaddr, sizeof(servaddr)) == - 1)
    {
        std::string s = "bind socket fail";
        DealError(s.c_str());
        return 0;
    }

    // 开始监听
    if (listen(socket_fd, 10) == -1)
    {
        std::string s = "listen socket fail";
        DealError(s.c_str());
    }

    while(1)
    {
        if ((connect_fd = accept(socket_fd, (struct sockaddr*)nullptr, nullptr)) == -1)
        {
            std::string s = "accept socket fail";
            DealError(s.c_str());
            continue;
        }

        // TODO： 考虑替换成recvmsg和sendmsg
        n = recv(connect_fd, buff, MAXLINE, 0);

        // fork()会创建一个子进程，并将父进程的所有值都复制到其中，相当于克隆了一个进程   
        // fork()被调用一次，会返回二次，在父进程中返回的值是子进程的进程ID, 在子进程中返回0, 若出现错误返回-1
        if (!fork()) // 子线程进入if逻辑
        {
            if (send(connect_fd, "Hello lebe\n", 12, 0) == -1)
            {
                perror("send error");
                close(connect_fd);
                exit(0);
            }
        }

        buff[n] = '\0';
        printf("recv msg from client, msg[%s]\n", buff);
        close(connect_fd)
    }
    close(socket_fd);

    return 0;
}