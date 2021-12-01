#!/bin/bash

cd /usr/local/src
wget -O mecab-0.996.tar.gz "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE"
wget -O mecab-ipadic-2.7.0-20070801.tar.gz "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM"
wget -O mecab-ruby-0.996.tar.gz "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7VUNlczBWVDZJbE0"
wget https://raw.githubusercontent.com/shirasagi/shirasagi/stable/vendor/mecab/mecab-ipadic-2.7.0-20070801.patch


cd /usr/local/src
tar xvzf mecab-0.996.tar.gz
cd mecab-0.996
./configure --enable-utf8-only
make
sudo make install
#cd
#sudo mv mecab-0.996 /usr/local/src
export PATH=/usr/local/bind:$PATH
echo export PATH='/usr/local/bin:$PATH' >> ~/.bash_profile
cd /usr/local/src
tar xvzf mecab-ipadic-2.7.0-20070801.tar.gz
cd mecab-ipadic-2.7.0-20070801
patch -p1 < ../mecab-ipadic-2.7.0-20070801.patch
./configure --with-charset=UTF-8 --with-mecab-config=/usr/local/bin/mecab-config
make
sudo make install
#cd
#sudo mv mecab-ipadic-2.7.0-20070801 /usr/local/src

cd /usr/local/src
tar xvzf mecab-ruby-0.996.tar.gz
cd mecab-ruby-0.996
ruby extconf.rb
make
sudo make install
#cd
#sudo mv mecab-ruby-0.996 /usr/local/src

echo "/usr/local/lib" | sudo tee -a /etc/ld.so.conf
sudo ldconfig

#### Voice

cd /usr/local/src
wget http://downloads.sourceforge.net/hts-engine/hts_engine_API-1.08.tar.gz \
  http://downloads.sourceforge.net/open-jtalk/open_jtalk-1.07.tar.gz \
    http://downloads.sourceforge.net/lame/lame-3.99.5.tar.gz \
      http://downloads.sourceforge.net/sox/sox-14.4.1.tar.gz

cd /usr/local/src
tar xvzf hts_engine_API-1.08.tar.gz
cd hts_engine_API-1.08
./configure
make
sudo make install

cd /usr/local/src
tar xvzf open_jtalk-1.07.tar.gz
cd open_jtalk-1.07
sed -i "s/#define MAXBUFLEN 1024/#define MAXBUFLEN 10240/" bin/open_jtalk.c
sed -i "s/0x00D0 SPACE/0x000D SPACE/" mecab-naist-jdic/char.def
./configure --with-charset=UTF-8
make
sudo make install

cd /usr/local/src
tar xvzf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure
make
sudo make install

cd /usr/local/src
tar xvzf sox-14.4.1.tar.gz
cd sox-14.4.1
./configure
make
sudo make install

sudo ldconfig

echo export PATH='/usr/local/bin:$PATH' >> ~/.bash_profile
source ~/.bash_profile
