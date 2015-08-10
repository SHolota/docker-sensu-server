Sensu server 
----------------------

This image contains:
- `Sensu-server`
- `Sensu-api`
- `Rabbitmq-server`
- `Redis-server`
- `Bsd-mailx` - for sent mail notifications

### Building the image ###

The Dockerfile and supporting configuration files are available in our [Github repository](https://github.com/SHolota/docker-sensu-server). This comes specially handy if you want to change any of the Sensu settings, or simply if you want to know how the image was built.

To build the container image from the repository you just need to run the following command:
```
$ git clone https://github.com/SHolota/docker-sensu-server.git
$ cd docker-sensu-server
-- do some changes --
$ docker build -t test/sensu

```
### Using the Docker Index ###

This image is published under our repository on the [Docker Index](https://registry.hub.docker.com/u/sgolota/docker-sensu-server/). 

Before start a container copy sensu config files from [Github repository](https://github.com/SHolota/docker-sensu-server/) in your host folder:

- `config.json` - example Sensu config 
- `main.cf` - example bsd-mailx config 

To start a container with this image you just need to run the following command:
```
docker run -d \
	-p 5672:5672 \
	-p 4567:4567 \
	-p 6379:6379 \
	-v /srv/sensu/config/conf.d:/etc/sensu/conf.d \
	-v /srv/sensu/config/handlers:/etc/sensu/handlers \
	sgolota/sensu-server
```
Once your container is running all you need to do:
find container id
```
$ docker ps
CONTAINER ID        IMAGE NAMES ...
3e955b3a7744        trmb/sensu  ...
```
and start script /tmp/start.sh
```
$ docker exec 3e955b3a7744 /tmp/start.sh
```

The container exposes the following ports:

- `5672`: the Rabbitmq port. 
- `4567`: the Sensu-api port.
- `6379`: the Redis port.

We use Data volumes to store the data on the host :

- `-v /srv/sensu/config/conf.d:/etc/sensu/conf.d`: store sensu config file
- `-v /srv/sensu/config/handlers:/etc/sensu/handlers`: store sensu handlers  

Here is an example that stores the data at /srv/sensu/.

### Configuring Sensu ###

You can see example of configurations in config folder [Github repository](https://github.com/SHolota/docker-sensu-server/tree/master/config):

- `checks.json` - example checks config 
- `handlers.json` - example handlers config (mail and grafite metrics) 
- `elasticsearch-metrics.json` - example elasticsearch config (elasticsearch metrics) 







