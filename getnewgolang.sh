#!/bin/bash 
#

HOMEPATH=/home/ubuntu
rm -rf /tmp/go*.tar.gz &> /dev/null 
newgolangurl="https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz"
wget -P /tmp/ $newgolangurl &>/dev/null
[ $? -ne 0 ] && echo "error!"
mkdir -p /opt/golang &>/dev/null 
mkdir -p /opt/golang/golib &>/dev/null 
tar -xf /tmp/go*.tar.gz -C /opt/golang
grep "GOROOT" -r $HOMEPATH/.*rc &> /dev/null 
if [ $? -ne 0 ];then
    echo "export GOROOT=/opt/golang/go" >> $HOMEPATH/.bashrc 
    echo "export GOROOT=/opt/golang/go" >> $HOMEPATH/.zshrc
    echo "export GOPATH=/opt/golang/golib:$HOMEPATH/golang/" >> $HOMEPATH/.bashrc
    echo "export GOPATH=/opt/golang/golib:$HOMEPATH/golang/" >> $HOMEPATH/.zshrc
    echo "export PATH=$PATH:$GOROOT/bin:/opt/golang/golib/bin" >> $HOMEPATH/.bashrc
    echo "export PATH=$PATH:$GOROOT/bin:/opt/golang/golib/bin" >> $HOMEPATH/.zshrc
    source $HOMEPATH/.bashrc &>/dev/null 
    source $HOMEPATH/.zshrc &>/dev/null
else
    sed -i "s%export GOROOT=.*%export GOROOT=/opt/golang/go%" $HOMEPATH/.bashrc 
    sed -i "s%export GOROOT=.*%export GOROOT=/opt/golang/go%" $HOMEPATH/.zshrc
    sed -i "s%export GOPATH=.*%export GOPATH=/opt/golang/golib:$HOMEPATH/golang%" $HOMEPATH/.bashrc
    sed -i "s%export GOPATH=.*%export GOPATH=/opt/golang/golib:$HOMEPATH/golang%" $HOMEPATH/.zshrc
    sed -i "s%export PATH=.*%export PATH=$PATH:\$GOROOT/bin:/opt/golang/golib/bin%" $HOMEPATH/.bashrc
    sed -i "s%export PATH=.*%export PATH=$PATH:\$GOROOT/bin:/opt/golang/golib/bin%" $HOMEPATH/.zshrc
    source $HOMEPATH/.bashrc &>/dev/null 
    source $HOMEPATH/.zshrc &>/dev/null
fi
go version 
[ $? -eq 0 ] && echo;echo;echo "golang install ok, welcome to use golang. have fun !";echo;
