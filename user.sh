script_path=$(dirname $0)
source ${script_path}/common.sh


echo -e "\e[36m>>>>>>>>> Configuring NodeJs repo <<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_18.x | sudo bash -

echo -e "\e[36m>>>>>>>>> Install NodeJs <<<<<<<<<\e[0m"
dnf install nodejs -y

echo -e "\e[36m>>>>>>>>> Add Application User <<<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[36m>>>>>>>>> Create Application Directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>>>> Download APP Content <<<<<<<<<\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app

echo -e "\e[36m>>>>>>>>> Unzip App Content <<<<<<<<<\e[0m"
unzip /tmp/user.zip

echo -e "\e[36m>>>>>>>>> Install Nodejs Dependencies <<<<<<<<<\e[0m"
npm install

echo -e "\e[36m>>>>>>>>> Start Create Application Directory <<<<<<<<<\e[0m"
cp ${script_path}/user.service /etc/systemd/system/user.service

echo -e "\e[36m>>>>>>>>> Start User Service <<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl start user

echo -e "\e[36m>>>>>>>>> Copy MongoDB repo <<<<<<<<<\e[0m"
cp /root/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> Install MongoDB client <<<<<<<<<\e[0m"
dnf install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>> Load schema <<<<<<<<<\e[0m"
mongo --host mongodb.saikumar22.store </app/schema/user.js