# docker-tor

## Installation

### From DockerHub

```
sudo docker pull hiroakis/tor
```

### Build

```
git clone git@github.com:hiroakis/docker-tor.git
cd docker-tor
sudo docker build -t your-name/tor .
```

## Run

```
sudo docker run --name tor \ 
  -p 9001:9001 \ 
  -p 9030:9030 \ 
  -v `pwd`:/tor/var/log/tor \ 
  --sysctl net.core.somaxconn=65535 \ 
  --sysctl "net.ipv4.ip_local_port_range=10000 65535" \ 
  --ulimit nofile=262144:262144 \ 
  -d \ 
  hiroakis/tor
```

## Debug

```
# login to docker container
sudo docker exec -it tor sh
curl -s --socks5 localhost:9050 https://ifconfig.io/
```

## License

MIT

