#include <stdio.h>
#include "WebService.h"
#include "Authentication.h"
//Rcp 服务端演示
int main()
{
	//启动web接口线程
	WebService  *pSrvProc = new WebService();
	pSrvProc->RegisterService(new CAuthentication);

	CHttpServerPtr pHttpSrv(pSrvProc);
	
	if (pHttpSrv->Start("0.0.0.0", 9090))
	{
		printf("创建web server 成功");
	}
	else
	{
		printf("创建web server 失败");
	}

	while (true)
	{
		Sleep(10000);
	}
}