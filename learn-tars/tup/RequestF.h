// **********************************************************************
// This file was generated by a TARS parser!
// TARS version 1.1.0.
// **********************************************************************

#ifndef __REQUESTF_H_
#define __REQUESTF_H_

#include <map>
#include <string>
#include <vector>
#include "Tars.h"
using namespace std;


namespace tars
{
    struct RequestPacket : public tars::TarsStructBase
    {
    public:
        static string className()
        {
            return "tars.RequestPacket";
        }
        static string MD5()
        {
            return "d50ef09f8b0adb190847de4849f28383";
        }
        RequestPacket()
        :iVersion(0),cPacketType(0),iMessageType(0),iRequestId(0),sServantName(""),sFuncName(""),iTimeout(0)
        {
        }
        void resetDefautlt()
        {
            iVersion = 0;
            cPacketType = 0;
            iMessageType = 0;
            iRequestId = 0;
            sServantName = "";
            sFuncName = "";
            iTimeout = 0;
        }
        template<typename WriterT>
        void writeTo(tars::TarsOutputStream<WriterT>& _os) const
        {
            _os.write(iVersion, 1);
            _os.write(cPacketType, 2);
            _os.write(iMessageType, 3);
            _os.write(iRequestId, 4);
            _os.write(sServantName, 5);
            _os.write(sFuncName, 6);
            _os.write(sBuffer, 7);
            _os.write(iTimeout, 8);
            _os.write(context, 9);
            _os.write(status, 10);
        }
        template<typename ReaderT>
        void readFrom(tars::TarsInputStream<ReaderT>& _is)
        {
            resetDefautlt();
            _is.read(iVersion, 1, true);
            _is.read(cPacketType, 2, true);
            _is.read(iMessageType, 3, true);
            _is.read(iRequestId, 4, true);
            _is.read(sServantName, 5, true);
            _is.read(sFuncName, 6, true);
            _is.read(sBuffer, 7, true);
            _is.read(iTimeout, 8, true);
            _is.read(context, 9, true);
            _is.read(status, 10, true);
        }
        ostream& display(ostream& _os, int _level=0) const
        {
            tars::TarsDisplayer _ds(_os, _level);
            _ds.display(iVersion,"iVersion");
            _ds.display(cPacketType,"cPacketType");
            _ds.display(iMessageType,"iMessageType");
            _ds.display(iRequestId,"iRequestId");
            _ds.display(sServantName,"sServantName");
            _ds.display(sFuncName,"sFuncName");
            _ds.display(sBuffer,"sBuffer");
            _ds.display(iTimeout,"iTimeout");
            _ds.display(context,"context");
            _ds.display(status,"status");
            return _os;
        }
        ostream& displaySimple(ostream& _os, int _level=0) const
        {
            tars::TarsDisplayer _ds(_os, _level);
            _ds.displaySimple(iVersion, true);
            _ds.displaySimple(cPacketType, true);
            _ds.displaySimple(iMessageType, true);
            _ds.displaySimple(iRequestId, true);
            _ds.displaySimple(sServantName, true);
            _ds.displaySimple(sFuncName, true);
            _ds.displaySimple(sBuffer, true);
            _ds.displaySimple(iTimeout, true);
            _ds.displaySimple(context, true);
            _ds.displaySimple(status, false);
            return _os;
        }
    public:
        tars::Short iVersion;
        tars::Char cPacketType;
        tars::Int32 iMessageType;
        tars::Int32 iRequestId;
        std::string sServantName;
        std::string sFuncName;
        vector<tars::Char> sBuffer;
        tars::Int32 iTimeout;
        map<std::string, std::string> context;
        map<std::string, std::string> status;
    };
    inline bool operator==(const RequestPacket&l, const RequestPacket&r)
    {
        return l.iVersion == r.iVersion && l.cPacketType == r.cPacketType && l.iMessageType == r.iMessageType && l.iRequestId == r.iRequestId && l.sServantName == r.sServantName && l.sFuncName == r.sFuncName && l.sBuffer == r.sBuffer && l.iTimeout == r.iTimeout && l.context == r.context && l.status == r.status;
    }
    inline bool operator!=(const RequestPacket&l, const RequestPacket&r)
    {
        return !(l == r);
    }

    struct ResponsePacket : public tars::TarsStructBase
    {
    public:
        static string className()
        {
            return "tars.ResponsePacket";
        }
        static string MD5()
        {
            return "0461398608abed5c7da44fac12c0c90e";
        }
        ResponsePacket()
        :iVersion(0),cPacketType(0),iRequestId(0),iMessageType(0),iRet(0),sResultDesc("")
        {
        }
        void resetDefautlt()
        {
            iVersion = 0;
            cPacketType = 0;
            iRequestId = 0;
            iMessageType = 0;
            iRet = 0;
            sResultDesc = "";
        }
        template<typename WriterT>
        void writeTo(tars::TarsOutputStream<WriterT>& _os) const
        {
            _os.write(iVersion, 1);
            _os.write(cPacketType, 2);
            _os.write(iRequestId, 3);
            _os.write(iMessageType, 4);
            _os.write(iRet, 5);
            _os.write(sBuffer, 6);
            _os.write(status, 7);
            if (sResultDesc != "")
            {
                _os.write(sResultDesc, 8);
            }
            if (context.size() > 0)
            {
                _os.write(context, 9);
            }
        }
        template<typename ReaderT>
        void readFrom(tars::TarsInputStream<ReaderT>& _is)
        {
            resetDefautlt();
            _is.read(iVersion, 1, true);
            _is.read(cPacketType, 2, true);
            _is.read(iRequestId, 3, true);
            _is.read(iMessageType, 4, true);
            _is.read(iRet, 5, true);
            _is.read(sBuffer, 6, true);
            _is.read(status, 7, true);
            _is.read(sResultDesc, 8, false);
            _is.read(context, 9, false);
        }
        ostream& display(ostream& _os, int _level=0) const
        {
            tars::TarsDisplayer _ds(_os, _level);
            _ds.display(iVersion,"iVersion");
            _ds.display(cPacketType,"cPacketType");
            _ds.display(iRequestId,"iRequestId");
            _ds.display(iMessageType,"iMessageType");
            _ds.display(iRet,"iRet");
            _ds.display(sBuffer,"sBuffer");
            _ds.display(status,"status");
            _ds.display(sResultDesc,"sResultDesc");
            _ds.display(context,"context");
            return _os;
        }
        ostream& displaySimple(ostream& _os, int _level=0) const
        {
            tars::TarsDisplayer _ds(_os, _level);
            _ds.displaySimple(iVersion, true);
            _ds.displaySimple(cPacketType, true);
            _ds.displaySimple(iRequestId, true);
            _ds.displaySimple(iMessageType, true);
            _ds.displaySimple(iRet, true);
            _ds.displaySimple(sBuffer, true);
            _ds.displaySimple(status, true);
            _ds.displaySimple(sResultDesc, true);
            _ds.displaySimple(context, false);
            return _os;
        }
    public:
        tars::Short iVersion;
        tars::Char cPacketType;
        tars::Int32 iRequestId;
        tars::Int32 iMessageType;
        tars::Int32 iRet;
        vector<tars::Char> sBuffer;
        map<std::string, std::string> status;
        std::string sResultDesc;
        map<std::string, std::string> context;
    };
    inline bool operator==(const ResponsePacket&l, const ResponsePacket&r)
    {
        return l.iVersion == r.iVersion && l.cPacketType == r.cPacketType && l.iRequestId == r.iRequestId && l.iMessageType == r.iMessageType && l.iRet == r.iRet && l.sBuffer == r.sBuffer && l.status == r.status && l.sResultDesc == r.sResultDesc && l.context == r.context;
    }
    inline bool operator!=(const ResponsePacket&l, const ResponsePacket&r)
    {
        return !(l == r);
    }


}



#endif
