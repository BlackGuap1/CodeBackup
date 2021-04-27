#include "RpcChannel.h"
#include "proto\Authentication.pb.h"
#include <google\protobuf\message_lite.h>
#include <google\protobuf\message.h>

#define PROTOBUF_PROTOCOL_FLAG 0xfafbfcfd

CRpcChannel::CRpcChannel(const std::string& srvAddr):m_strSrvAddr(srvAddr)
{
}

CRpcChannel::~CRpcChannel()
{
}

void CRpcChannel::CallMethod(const proto::MethodDescriptor* method,
	proto::RpcController* controller,
	const proto::Message* request,
	proto::Message* response,
	proto::Closure* done)
{
	Auth::RpcProtocol message;
	message.set_serviceid(method->service()->index());
	message.set_methodid(method->index());
	message.set_falg(PROTOBUF_PROTOCOL_FLAG);
	message.set_data(request->SerializeAsString());

	CHttpSyncClientPtr httpReq(nullptr);
	std::string strBody = message.SerializeAsString();
	int nSize = strBody.size();
	std::string strBodySize = std::to_string(nSize);

	THeader header[] = { { "Content-Type", "text/plain;charset=utf-8" },{ "Content-Length", strBodySize.c_str() } };

	int iHeaderCount = sizeof(header) / sizeof(THeader);
 
	if (!httpReq->OpenUrl("GET", m_strSrvAddr.c_str(), header, iHeaderCount, (const BYTE*)strBody.c_str(), strBody.size()))
	{
		printf("·¢ËÍ½á¹ûÊ§°Ü");
		return;
	}
	
	BYTE * respBody = nullptr;
	int len = 0;
	if (httpReq->GetResponseBody((LPCBYTE*)&respBody, &len) == FALSE)
		return;

	response->ParseFromString((char*)respBody);
}