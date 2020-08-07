#!/bin/bash
echo_and_run() {
    echo "$@";
    "$@";
}


echo "listing out cluster ..."
echo_and_run docker exec -it ejabberd01 bin/ejabberdctl --no-timeout list_cluster

echo "unregister admin on ejabberd01..."
echo_and_run docker exec -it ejabberd01 bin/ejabberdctl unregister admin mycluster.com
echo "unregister user01 on ejabberd01..."
echo_and_run docker exec -it ejabberd01 bin/ejabberdctl unregister user01 mycluster.com
echo "unregister user02 on ejabberd02..."
echo_and_run docker exec -it ejabberd02 bin/ejabberdctl unregister user02 mycluster.com
echo "check registrations on ejabberd01..."
echo_and_run docker exec -it ejabberd02 bin/ejabberdctl registered_users mycluster.com
echo "check registrations on ejabberd02..."
echo_and_run docker exec -it ejabberd02 bin/ejabberdctl registered_users mycluster.com


## Commented out - this was cause ejabberd02 to shutdown - per design
#echo "ejabberd02 leaving cluster with ejabberd01..."
#echo_and_run docker exec -it ejabberd02 bin/ejabberdctl --no-timeout leave_cluster 'ejabberd@ejabberd01'
