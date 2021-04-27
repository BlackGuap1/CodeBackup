#pragma once
#include <HPSocket/HPSocket.h>
#include <map>
#include <google/protobuf/service.h>
namespace protoBuf = google::protobuf;

//webÇëÇó·þÎñ
class WebService : public CHttpServerListener
{
public:
	WebService();
	~WebService();

	void RegisterService(protoBuf::Service * pService);
private:
	virtual EnHttpParseResult OnHeadersComplete(IHttpServer* pSender, CONNID dwConnID);
	virtual EnHttpParseResult OnBody(IHttpServer* pSender, CONNID dwConnID, const BYTE* pData, int iLength);
	virtual EnHttpParseResult OnChunkHeader(IHttpServer* pSender, CONNID dwConnID, int iLength);
	virtual EnHttpParseResult OnChunkComplete(IHttpServer* pSender, CONNID dwConnID);
	virtual EnHttpParseResult OnMessageComplete(IHttpServer* pSender, CONNID dwConnID);

	virtual EnHandleResult OnClose(ITcpServer* pSender, CONNID dwConnID, EnSocketOperation enOperation, int iErrorCode);

	virtual EnHttpParseResult OnParseError(IHttpServer* pSender, CONNID dwConnID, int iErrorCode, LPCSTR lpszErrorDesc);

private:
	std::map<int, protoBuf::Service*> m_mapService;
};

