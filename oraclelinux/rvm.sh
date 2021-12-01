#!/bin/bash
sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo dnf config-manager --disable epel
sudo dnf config-manager --disable epel-modular
sudo dnf -y --enablerepo=epel,ol8_codeready_builder install ImageMagick ImageMagick-devel libyaml-devel
for i in $(seq 1 3)
do
  \curl -sSL https://rvm.io/mpapis.asc | gpg --import - ; RET1=$?
  \curl -sSL https://rvm.io/pkuczynski.asc | gpg --import - ; RET2=$?
  if [ ${RET1} -eq 0 -a ${RET2} -eq 0 ]; then
    break
  fi
  sleep 5s
done

\curl -sSL https://get.rvm.io | bash -s stable
if [ `whoami` = root ]; then
  RVM_HOME=/usr/local/rvm
else
  RVM_HOME=$HOME/.rvm
fi
export PATH="$PATH:$RVM_HOME/bin"
source $RVM_HOME/scripts/rvm
rvm install 2.6.3 --disable-binary
rvm use 2.6.3 --default
gem install bundler
