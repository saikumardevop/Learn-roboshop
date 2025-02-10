script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head "Install Redis Repos"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm  --nobest -y
func_stat_check $?

func_print_head "Install Redis"
dnf module enable redis: remi-6.2 -y
yum install redis -y 
func_stat_check $?

func_print_head "Update Redis Listen Address"
sed -i -e 's|127.0.0.1|0.0.0.0|' etc/redis.conf /etc/redis/redis.conf 
func_stat_check $?

func_print_head "Start Redis Service"
systemctl enable redis 
systemctl restart redis 
func_stat_check $?










