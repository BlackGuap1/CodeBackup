#include <iostream>
#include "RpcChannel.h"
#include "RpcController.h"
#include "proto\Authentication.pb.h"
//Rcp ¿Í»§¶ËÑÝÊ¾
int main()
{
	std::string strSrvAddr = "http://127.0.0.1:9090";
	CRpcChannel channel(strSrvAddr);

	CRpcController pController;
	Auth::Authentication::Stub stub(&channel);
	Auth::UserInfo req;
	Auth::ResponseMsg res;

	req.set_phonenum("10086");
	stub.UserApplyReg(&pController, &req, &res, NULL);
	std::cout << res.message() << std::endl;

	req.set_password("********");
	stub.UserRegister(&pController, &req, &res, NULL);
	std::cout << res.message() << std::endl;

	stub.UserLogin(&pController, &req, &res, NULL);
	std::cout << res.message() << std::endl;
}