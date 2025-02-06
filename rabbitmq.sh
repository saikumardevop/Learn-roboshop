script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

if [ -z "$rabbitmq_appuser_password"]; then
  echo Input Roboshop Appuser password missing
  exit
fi

func_print_head "Setup Erlang Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash $<<log_files
func_stat_check $?

func_print_head "Setup Rabbitmq Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash $<<log_files
func_stat_check $?

func_print_head "Install Erlang RabbitMQ"
dnf install erlang rabbitmq-server -y $<<log_files
func_stat_check $?

func_print_head "Start RabbitMQ Service"
systemctl enable rabbitmq-server $<<log_files
systemctl restart rabbitmq-server $<<log_files
func_stat_check $?


func_print_head "Add Application User In RabbitMQ"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
func_stat_check $?
