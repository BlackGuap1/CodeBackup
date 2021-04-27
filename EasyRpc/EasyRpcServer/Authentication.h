#pragma once

#include "proto\Authentication.pb.h"

//服务类接口实现
class CAuthentication : public Auth::Authentication
{
public:
	virtual void UserApplyReg(::google::protobuf::RpcController* controller,
		const ::Auth::UserInfo* request,
		::Auth::ResponseMsg* response,
		::google::protobuf::Closure* done);
	virtual void UserRegister(::google::protobuf::RpcController* controller,
		const ::Auth::UserInfo* request,
		::Auth::ResponseMsg* response,
		::google::protobuf::Closure* done);
	virtual void UserLogin(::google::protobuf::RpcController* controller,
		const ::Auth::UserInfo* request,
		::Auth::ResponseMsg* response,
		::google::protobuf::Closure* done);
};