# Update Ruby to 1.9.3
# https://www.digitalocean.com/community/articles/how-to-install-ruby-on-rails-on-centos-6-with-rvm
# http://elruby.websages.com/
# http://www.rosehosting.com/blog/how-to-install-ruby-1-9-3-and-rubygems-1-8-24-on-centos-6-2/
# http://www.server-world.info/en/note?os=CentOS_6&p=ruby19
# https://github.com/imeyer/ruby-1.9.3-rpm
# Get the EPEL RPM
sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
# Update Indexes
sudo yum check-update -y
# Updates
# sudo yum update -y

# sudo yum install -y rpm-build rpmdevtools readline-devel ncurses-devel gdbm-devel tcl-devel openssl-devel db4-devel byacc libyaml-devel libffi-devel make
# rpmdev-setuptree
# cd ~/rpmbuild/SOURCES
# RUBY_VER=ruby-1.9.3
# RUBY_SUBVER=p484
# wget http://ftp.ruby-lang.org/pub/ruby/1.9/${RUBY_VER}-${RUBY_SUBVER}.tar.gz
# cd ~/rpmbuild/SPECS
# wget https://raw.github.com/imeyer/${RUBY_VER}-rpm/master/ruby19.spec
# sudo rpmbuild -bb ruby19.spec
# ARCH=`uname -m`
# KERNEL_REL=`uname -r`
# KERNEL_TMP=${KERNEL_REL%.$ARCH}
# DISTRIB=${KERNEL_TMP##*.}
# sudo yum -y localinstall ~/rpmbuild/RPMS/${ARCH}/${RUBY_VER}${RUBY_SUBVER}-1.${DISTRIB}.${ARCH}.rpm

# ruby --version
# sudo gem update --system

#Charlie's method (a slightly weird SCL)
cd /etc/yum.repos.d && sudo curl -O http://people.redhat.com/bkabrda/scl_ruby193.repo
sudo yum install -y ruby193
#scl enable ruby193 "puppet resource package"
