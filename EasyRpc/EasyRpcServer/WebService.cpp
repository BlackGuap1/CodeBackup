#include "WebService.h"
#include <string>
#include <google/protobuf/descriptor.h>
#include "proto\Authentication.pb.h"
#include "RpcController.h"

WebService::WebService()
{
}

WebService::~WebService()
{
}

void WebService::RegisterService(protoBuf::Service* pService)
{
	m_mapService[pService->GetDescriptor()->index()] = pService;
}


EnHttpParseResult WebService::OnHeadersComplete(IHttpServer * pSender, CONNID dwConnID)
{
	return HPR_OK;
}

EnHttpParseResult WebService::OnBody(IHttpServer * pSender, CONNID dwConnID, const BYTE * pData, int iLength)
{
	char *pszBuf = new char[iLength + 1];
	memset(pszBuf, 0, iLength + 1);
	memcpy_s(pszBuf, iLength, pData, iLength);

	pSender->SetConnectionExtra(dwConnID, pszBuf);
	return HPR_OK;
}

EnHttpParseResult WebService::OnChunkHeader(IHttpServer * pSender, CONNID dwConnID, int iLength)
{
	return HPR_OK;
}

EnHttpParseResult WebService::OnChunkComplete(IHttpServer * pSender, CONNID dwConnID)
{
	return HPR_OK;
}

EnHttpParseResult WebService::OnMessageComplete(IHttpServer * pSender, CONNID dwConnID)
{
	char* pszBuf = nullptr;
	pSender->GetConnectionExtra(dwConnID, (VOID**)&pszBuf);

	char szBuf[64] = { 0 };
	int nSize = sizeof(szBuf);
	USHORT nPort;
	pSender->GetRemoteAddress(dwConnID, szBuf, nSize, nPort);

	Auth::RpcProtocol protoMsg;
	if (!protoMsg.ParseFromString(pszBuf))
	{
		std::cout << "无效消息" << std::endl;
		return HPR_ERROR;
	}
	
	if (m_mapService.find(protoMsg.serviceid()) != m_mapService.end())
	{
		auto pRpcMonitor = m_mapService[protoMsg.serviceid()];
		const protoBuf::ServiceDescriptor *service_descriptor = pRpcMonitor->GetDescriptor();


		const protoBuf::MethodDescriptor *method_descriptor = service_descriptor->method(protoMsg.methodid());
		const protoBuf::Message& request_proto = pRpcMonitor->GetRequestPrototype(method_descriptor);
		const protoBuf::Message& response_proto = pRpcMonitor->GetResponsePrototype(method_descriptor);

		protoBuf::Message *reqMsg = request_proto.New();
		reqMsg->ParseFromString(protoMsg.data());
		protoBuf::Message *resMsg = response_proto.New();
		CRpcController pController(szBuf);
		pRpcMonitor->CallMethod(method_descriptor, &pController, reqMsg, resMsg, NULL);

		std::string strBody = resMsg->SerializeAsString();
		int nSize = strBody.size();
		std::string strBodySize = std::to_string(nSize);
		THeader header[] = { { "Content-Type", "text/plain;charset=utf-8" },{ "Content-Length", strBodySize.c_str() } };
		
		int iHeaderCount = sizeof(header) / sizeof(THeader);
		pSender->SendResponse(dwConnID,
			HSC_OK,
			"Http Server OK",
			header, iHeaderCount,
			(const BYTE*)strBody.c_str(),
			strBody.size());
	}
	return HPR_OK;
}


EnHandleResult WebService::OnClose(ITcpServer * pSender, CONNID dwConnID, EnSocketOperation enOperation, int iErrorCode)
{
	return HR_OK;
}

EnHttpParseResult WebService::OnParseError(IHttpServer * pSender, CONNID dwConnID, int iErrorCode, LPCSTR lpszErrorDesc)
{
	return HPR_OK;
}


