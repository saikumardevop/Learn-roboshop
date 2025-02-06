script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh


func_print_head "Install Nginx"
dnf install nginx -y  $>>$log file
func_stat_check $?

func_print_head "Copy roboshop Config file"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$log file
func_stat_check $?

func_print_head "Clean old App Content"
rm -rf /usr/share/nginx/html/* &>>$log file
func_stat_check $?

func_print_head "Download App Content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>$log file
func_stat_check $?

func_print_head "Extracting App Content"
cd /usr/share/nginx/html &>>$log file
unzip /tmp/frontend.zip &>>$log file
func_stat_check $?

func_print_head "Start Nginx"
systemctl enable nginx &>>$log file
systemctl restart nginx &>>$log file
func_stat_check $?
