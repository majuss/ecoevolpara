create ccnet-init

# git clone ccnet install g++ gcc make valac >= 0.8 libsearpc1 automake libparted-dev sqlite3 libsqlite3-dev libsearpc-dev build-essential libglib2.0-dev

git clone https://github.com/haiwen/libsearpc.git
rm aclocal.m4

mkdir m4

autoreconf -i --install --force

autogen.sh; ./configure; make; make install

git clone https://github.com/haiwen/ccnet.git
