#include "../include/Socket.h"

int main(int argc, char** argv)
{
    int sockfd, n, recv_len;
    char recvline[4096], sendline[4096];
    char buf[MAXLINE];
    struct sockaddr_in servaddr;    // ipv4 socket地址

    if (argc != 2)
    {
        printf("try again, usage: ./client <ipaddress> \n");
        return 0;
    }

    if (sockfd = socket(AF_INET, SOCK_STREAM, 0) < 0)
    {
        std::string s = "creat socket fail";
        DealError(s.c_str());
        return 0;
    }

    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(8000);
    // int inet_pton
    // 将点分十进制的ip地址转化为用于网络传输的数值格式
    // 若成功 返回1，若输入不是有效的表达式返回0，若出错返回-1
    if (inet_pton(AF_INET, argv[1], &servaddr.sin_addr) <= 0)
    {
        printf("inet_pton error or %s \n", argv[1]);
        return 0;
    }

    if (connect(sockfd, (struct sockaddr*) &servaddr, sizeof(servaddr)) < 0)
    {
        std::string s = "connect fail";
        DealError(s.c_str());
        return 0;
    }

    printf("send msg to server: \n");
    fgets(sendline, 4096, stdin);
    if (send(sockfd, sendline, strlen(sendline), 0) < 0)
    {
        std::string s = "send msg fail";
        DealError(s.c_str());
        return 0;
    }

    if ((recv_len = recv(sockfd, buf, MAXLINE, 0)) == -1)
    {
        std::string s = "recv msg fail";
        DealError(s.c_str());
        return 0;
    }

    buf[recv_len] = '\0';
    printf("Received: %s", buf);
    close(sockfd);

    return 0;
}