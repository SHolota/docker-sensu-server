FROM     ubuntu:14.04.1

MAINTAINER Sergey Holota serg.holota@gmail.com

# ----------------- #
#      Install      #
# ----------------- #

RUN		apt-get update
RUN		apt-get -y install wget
RUN		wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
RUN		apt-key add rabbitmq-signing-key-public.asc
RUN		echo "deb     http://www.rabbitmq.com/debian/ testing main" | sudo tee /etc/apt/sources.list.d/rabbitmq.list
RUN 	wget -q http://repos.sensuapp.org/apt/pubkey.gpg -O- | sudo apt-key add -
RUN 	echo "deb     http://repos.sensuapp.org/apt sensu main" | sudo tee /etc/apt/sources.list.d/sensu.list
RUN		apt-get update

RUN		apt-get -y install erlang-nox rabbitmq-server redis-server sensu supervisor vim bsd-mailx

# ----------------- #
#   Configuration   #
# ----------------- #

ADD 	./config.json /etc/sensu/config.json
ADD 	./main.cf /etc/postfix/main.cf

# ---------------- #
#   Expose Ports   #
# ---------------- #

EXPOSE 5672
EXPOSE 4567
EXPOSE 6379

# -------- #
#   Run!   #
# -------- #

ADD start.sh /tmp/start.sh
RUN chmod +x /tmp/start.sh