#!/usr/bin/python3

import socket
import sys

def check_ip_port(ip,port,timeout=0.1):
    _ret = 0
    sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sk.settimeout(timeout)
    try:
      sk.connect((ip,int(port)))
      print('ip:%s port %s OK!\n' %(ip, port))
    except Exception:
      print('ip:%s port %s not connect!\n' %(ip, port))
      _ret = -1
    sk.close()
    return _ret

#print("argc= " ,len(sys.argv))
#print(sys.argv)
if len(sys.argv) < 3:
    print("please input %s ip port\n" %(sys.argv[0]))
else:
    ipaddr=sys.argv[1]
    port=sys.argv[2]
    #print("ip:", ipaddr, "port:", port)
    if check_ip_port(ipaddr,port,2) == 0:
        sys.exit(0)
    else:
        sys.exit(2)
