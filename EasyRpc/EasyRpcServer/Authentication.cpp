#include "Authentication.h"

void CAuthentication::UserApplyReg(::google::protobuf::RpcController * controller, const::Auth::UserInfo * request, ::Auth::ResponseMsg * response, ::google::protobuf::Closure * done)
{
	std::cout << "用户：" << request->phonenum() << "申请" << std::endl;
	response->set_code(0);
	response->set_message("允许申请");
}

void CAuthentication::UserRegister(::google::protobuf::RpcController * controller, const::Auth::UserInfo * request, ::Auth::ResponseMsg * response, ::google::protobuf::Closure * done)
{
	std::cout << "用户：" << request->phonenum() << ", 密码 " << request->password() << "正在注册" << std::endl;
	response->set_code(0);
	response->set_message("注册成功");
}

void CAuthentication::UserLogin(::google::protobuf::RpcController * controller, const::Auth::UserInfo * request, ::Auth::ResponseMsg * response, ::google::protobuf::Closure * done)
{
	std::cout << "用户：" << request->phonenum() << ", 密码 " << request->password() << "正在登陆" << std::endl;
	response->set_code(0);
	response->set_message("登陆成功");
}
