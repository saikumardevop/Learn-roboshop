script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

if [ -z "$rabbitmq_appuser_password"]; then
  echo Input Roboshop Appuser password missing
  exit
fi

func_print_head "Setup Erlang Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash $<<log_file

func_stat_check $?

func_print_head "Setup Rabbitmq Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash $<<log_file
func_stat_check $?

func_print_head "Install Erlang RabbitMQ"
dnf install erlang rabbitmq-server -y $<<log_file
func_stat_check $?

func_print_head "Start RabbitMQ Service"
systemctl enable rabbitmq-server $<<log_file
systemctl restart rabbitmq-server $<<log_file
func_stat_check $?


func_print_head "Add Application User In RabbitMQ"
rabbitmqctl add_user roboshop roboshop123 $<<log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" $<<log_file
func_stat_check $?
