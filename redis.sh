script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head "Install Redis Repos"
yum install remi-release-8.10-2.el8.remi.noarch --nobest -y
func_stat_check $?

func_print_head "Install Redis"
sudo yum install remi-release-8.10-2.el8.remi.noarch --skip-broken -y
yum repolist
yum install redis -y 
func_stat_check $?

func_print_head "Update Redis Listen Address"
sed -i -e 's|127.0.0.1|0.0.0.0|' etc/redis.conf /etc/redis/redis.conf 
func_stat_check $?

func_print_head "Start Redis Service"
systemctl enable redis 
systemctl restart redis 
func_stat_check $?










