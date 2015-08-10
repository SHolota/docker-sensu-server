/etc/init.d/rabbitmq-server start
rabbitmqctl add_vhost /sensu
rabbitmqctl add_user sensu passpass
rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"

/etc/init.d/redis-server start
/etc/init.d/sensu-server start
/etc/init.d/sensu-api start
# we must restart postfix to use our settings
/etc/init.d/postfix restart
