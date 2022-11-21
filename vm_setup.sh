#! /usr/bin/env bash

ARCH="arm64"
if [[ `uname -m` == "x86_64" ]];
then
    ARCH="amd64"
fi

# vim 설치 및 설정
apt-get update \
&& apt-get install vim -y \
&& echo -e "set nu\nsyntax on\nset mouse=a\nset shiftwidth=4\nset tabstop=4" > /root/.vimrc

# git & curl 설치
apt-get install git curl -y

# oh-my-bash 설치
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# man page 설치
apt-get install manpages-dev -y

# gcc 설치
apt-get install gcc -y

# pidtree 설치
curl -LO https://go.dev/dl/go1.19.3.linux-${ARCH}.tar.gz && tar -C /usr/local -xzf /root/go1.19.3.linux-${ARCH}.tar.gz

export PATH=$PATH:/usr/local/go/bin

apt-get install make -y

git clone https://github.com/thediveo/lxkns.git && make install -C lxkns

rm -rf go1.19.3.linux-${ARCH}.tar.gz lxkns

# docker 설치
apt-get install \
    ca-certificates \
    gnupg \
    lsb-release -y

mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update \
&& apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# docker-compose 설치
curl -L https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-linux-aarch64 -o /usr/local/bin/docker-compose \
&& chmod +x /usr/local/bin/docker-compose

# bridge utils 설치
apt-get install bridge-utils -y

# net-tools 설치
apt-get install net-tools -y

# set timezone
ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

exec bash

clear

docker --version
docker-compose --version
go version
pidtree --version
brctl --version

service docker start

echo '{"features":{"buildkit":true}}' > /etc/docker/daemon.json
