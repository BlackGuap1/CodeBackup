#pragma once

#include <HPSocket/HPSocket.h>
#include <google/protobuf/service.h>
namespace proto = google::protobuf;



class CRpcChannel : public proto::RpcChannel
{
public:
	CRpcChannel(const std::string& srvAddr);
	~CRpcChannel();

	virtual void CallMethod(const proto::MethodDescriptor* method,
		proto::RpcController* controller,
		const proto::Message* request,
		proto::Message* response,
		proto::Closure* done);
private:
	std::string m_strSrvAddr;
};

