script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[36m>>>>>>>>> Disable MySQL Version <<<<<<<<<\e[0m"
dnf module disable mysql -y

echo -e "\e[36m>>>>>>>>> Copy MySQL Repo File <<<<<<<<<\e[0m"
cp ${script_path}/cart.service /etc/yum.repos.d/mysql.repo

echo -e "\e[36m>>>>>>>>> Install MySQL <<<<<<<<<\e[0m"
dnf install mysql-community-server -y

echo -e "\e[36m>>>>>>>>> Start MySQL <<<<<<<<<\e[0m"
systemctl enable mysqld
systemctl start mysqld

echo -e "\e[36m>>>>>>>>> Reset MySQL Password <<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
