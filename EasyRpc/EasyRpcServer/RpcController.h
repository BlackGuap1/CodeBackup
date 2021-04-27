#pragma once
#include <google/protobuf/service.h>
#include <string>


/*
* 辅助类 用于描述请求过程中的错误信息 
*/
class CRpcController : public google::protobuf::RpcController
{
public:
	CRpcController(){}
	CRpcController(const std::string& strIp) :m_strIp(strIp){ Reset(); }
	void Reset()
	{
		_error_str = "";
		_is_failed = false;
	}

	bool Failed() const
	{
		return _is_failed;
	}

	std::string ErrorText() const
	{
		return _error_str;
	}

	void StartCancel()
	{ // NOT IMPL
		return;
	}

	void SetFailed(const std::string &reason)
	{
		_is_failed = true;
		_error_str = reason;
	}

	bool IsCanceled() const
	{ // NOT IMPL
		return false;
	}


	void NotifyOnCancel(google::protobuf::Closure* callback)
	{ // NOT IMPL
		return;
	}
	std::string GetIp()
	{
		return m_strIp;
	}
private:
	std::string _error_str;
	std::string m_strIp;
	bool _is_failed;
};

