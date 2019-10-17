---
title: "Coding Test"
date: 2013-09-06 02:17
categories: code

---

Here is a script:

```
#!/bin/sh

echo "Cleaning up the manager"
echo -n "This will delete the manager database,are you sure ? [y/N] "
read answer
if [[ $answer != [Yy] ]]; then
 exit 1
fi

echo "Shutting down manager server"
service ovmm stop

echo "Removing database"
cd /u01/app/oracle/ovm-manager-3/weblogic; source /u01/app/oracle/Middleware/wlserver_10.3/server/bin/setWLSEnv.sh; ant -Ddb.password=Welcome1 clean_database

echo "Shutting down manager server"
service ovmm start

echo "Done! the manager will be up and ready in two minutes"

```

Neat-o!
