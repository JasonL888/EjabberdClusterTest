#!/bin/bash
echo_and_run() {
    echo "$@";
    "$@";
}

echo "ejabberd02 joining cluster with ejabberd01..."
echo_and_run docker exec -it ejabberd02 bin/ejabberdctl --no-timeout join_cluster 'ejabberd@ejabberd01'
echo "listing out cluster ..."
echo_and_run docker exec -it ejabberd02 bin/ejabberdctl --no-timeout list_cluster
echo "registering admin and user01 on ejabberd01..."
echo_and_run docker exec -it ejabberd01 bin/ejabberdctl register admin mycluster.com password
echo_and_run docker exec -it ejabberd01 bin/ejabberdctl register user01 mycluster.com password
echo "registering user02 on ejabberd02..."
echo_and_run docker exec -it ejabberd02 bin/ejabberdctl register user02 mycluster.com password
echo "check registrations on ejabberd01..."
echo_and_run docker exec -it ejabberd02 bin/ejabberdctl registered_users mycluster.com
echo "check registrations on ejabberd02..."
echo_and_run docker exec -it ejabberd02 bin/ejabberdctl registered_users mycluster.com
