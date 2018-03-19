event bro_init()
    {
    #disable all analyzers
    #comment out only those analyzers that are needed for logging
    Analyzer::disable_analyzer(Analyzer::ANALYZER_AYIYA);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_BACKDOOR);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_BITTORRENT);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_BITTORRENTTRACKER);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_CONNSIZE);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_DCE_RPC);
    #Uncomment to diable DHCP logs
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_DHCP);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_DNP3_TCP);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_DNP3_UDP);
    #Uncomment to disble DNS
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_CONTENTS_DNS);
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_DNS);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_FTP_DATA);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_IRC_DATA);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_FINGER);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_FTP);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_GNUTELLA);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_GSSAPI);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_GTPV1);
    #Uncomment to diable HTTP logs
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_HTTP);
    #Uncomment to disable ICMP logs
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_ICMP);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_IDENT);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_IMAP);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_INTERCONN);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_IRC);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_KRB);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_KRB_TCP);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_CONTENTS_RLOGIN);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_CONTENTS_RSH);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_LOGIN);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_NVT);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_RLOGIN);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_RSH);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_TELNET);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_MODBUS);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_MYSQL);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_CONTENTS_NCP);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_NCP);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_CONTENTS_NETBIOSSSN);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_NETBIOSSSN);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_NTLM);
    #Uncomment to disable NTP logs
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_NTP);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_PIA_TCP);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_PIA_UDP);
    #Uncomment to disable POP3 logs
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_POP3);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_RADIUS);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_RDP);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_RFB);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_CONTENTS_NFS);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_CONTENTS_RPC);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_NFS);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_PORTMAPPER);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_SIP);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_CONTENTS_SMB);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_SMB);
    #Uncomment to disable SMTP logs
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_SMTP);
    #Uncomment to disable SNMP logs
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_SNMP);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_SOCKS);
    #Uncomment to disable SSH logs
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_SSH);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_DTLS);
    #Uncomment to disable SSL logs
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_SSL);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_STEPPINGSTONE);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_SYSLOG);
    #Uncomment to disable TCP logs
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_CONTENTLINE);
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_CONTENTS);
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_TCP);
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_TCPSTATS);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_TEREDO);
    #Uncomment to disable UDP logs
    #Analyzer::disable_analyzer(Analyzer::ANALYZER_UDP);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_XMPP);
    Analyzer::disable_analyzer(Analyzer::ANALYZER_ZIP);
   


    #remove log streams
    #comment out only those logs that are needed    
    Log::disable_stream(Files::LOG);
    Log::disable_stream(Reporter::LOG);
    Log::disable_stream(Notice::LOG);
    Log::disable_stream(Notice::ALARM_LOG);
    Log::disable_stream(Weird::LOG);
    Log::disable_stream(NetControl::LOG);
    Log::disable_stream(OpenFlow::LOG);
    Log::disable_stream(Cluster::LOG);
    Log::disable_stream(NetControl::DROP);
    Log::disable_stream(NetControl::SHUNT);
    Log::disable_stream(NetControl::CATCH_RELEASE);
    Log::disable_stream(DPD::LOG);
    Log::disable_stream(Signatures::LOG);
    Log::disable_stream(PacketFilter::LOG);
    Log::disable_stream(Software::LOG);
    Log::disable_stream(Communication::LOG);
    Log::disable_stream(Intel::LOG);
    Log::disable_stream(Tunnel::LOG);
    #Log::disable_stream(Conn::LOG);
    Log::disable_stream(DCE_RPC::LOG);
    #Log::disable_stream(DHCP::LOG);
    Log::disable_stream(DNP3::LOG);
    #Log::disable_stream(DNS::LOG);
    Log::disable_stream(FTP::LOG);
    #Log::disable_stream(SSL::LOG);
    Log::disable_stream(X509::LOG);
    #Log::disable_stream(HTTP::LOG);
    Log::disable_stream(IRC::LOG);
    Log::disable_stream(KRB::LOG);
    Log::disable_stream(Modbus::LOG);
    Log::disable_stream(mysql::LOG);
    Log::disable_stream(NTLM::LOG);
    Log::disable_stream(RADIUS::LOG);
    Log::disable_stream(RDP::LOG);
    Log::disable_stream(RFB::LOG);
    Log::disable_stream(SIP::LOG);
    #Log::disable_stream(SNMP::LOG);
    #Log::disable_stream(SMTP::LOG);
    Log::disable_stream(SOCKS::LOG);
    #Log::disable_stream(SSH::LOG);
    Log::disable_stream(Syslog::LOG);
    Log::disable_stream(PE::LOG);
    Log::disable_stream(Unified2::LOG);
    #Log::disable_stream(Barnyard2::LOG);
    Log::disable_stream(CaptureLoss::LOG);
    #Log::disable_stream(Traceroute::LOG);
    #Log::disable_stream(Known::DEVICES_LOG);
    Log::disable_stream(LoadedScripts::LOG);
    Log::disable_stream(Stats::LOG);
    Log::disable_stream(Known::HOSTS_LOG);
    Log::disable_stream(Known::SERVICES_LOG);
    #Log::disable_stream(Known::MODBUS_LOG);
    #Log::disable_stream(Modbus::REGISTER_CHANGE_LOG);
    #Log::disable_stream(SMB::CMD_LOG);
    #Log::disable_stream(SMB::AUTH_LOG);
    #Log::disable_stream(SMB::MAPPING_LOG);
    #Log::disable_stream(SMB::FILES_LOG);
    Log::disable_stream(Known::CERTS_LOG);
    #Log::disable_stream(BroxygenExample::LOG);
    }
