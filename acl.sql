
begin
dbms_network_acl_admin.append_host_ace(host=>'127.0.0.1',  
                           ace=> sys.xs$ace_type(privilege_list=>sys.XS$NAME_LIST('JDWP') ,
                           principal_name=>'C##PLSQL',
                           principal_type=>sys.XS_ACL.PTYPE_DB) );
end;
/
