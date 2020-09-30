
clear

apt install autoconf bison clang coreutils curl findutils git apr apr-util libffi-dev libgmp-dev libpcap-dev postgresql-dev readline-dev libsqlite-dev openssl-dev libtool libxml2-dev libxslt-dev ncurses-dev pkg-config postgresql-contrib wget make ruby-dev libgrpc-dev ncurses-utils termux-tools -y

mv metasploit meta1.tar.gz
tar -xf meta1.tar.gz
mv framework meta2.tar.gz
tar -xf meta2.tar.gz
rm meta1.tar.gz meta2.tar.gz
mv meta1 meta
mv meta2/* meta/
rm -rf meta2
cd meta

sed '/rbnacl/d' -i Gemfile.lock
sed '/rbnacl/d' -i metasploit-framework.gemspec

gem install bundler
gem install bundler:1.15.4
bundle config build.nokogiri --use-system-libraries
gem install nokogiri -- --use-system-libraries
 
cd meta/grpc-1.4.1

patch -p1 < extconf.patch
gem build grpc.gemspec
gem install grpc-1.4.1.gem

cd ..

bundle install -j5

$PREFIX/bin/find -type f -executable -exec termux-fix-shebang \{\} \;
rm ./modules/auxiliary/gather/http_pdf_authors.rb
ln -s msfconsole /data/data/com.termux/files/usr/bin/


echo "Done"