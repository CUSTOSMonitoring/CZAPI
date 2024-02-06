#vim: set ts=3 expandtab:

def DateToString ( unixtime ):
   if unixtime != "0" then unixtime | tonumber | strflocaltime("%Y-%m-%d %H:%M:%S")
                         else ""
                         end;
