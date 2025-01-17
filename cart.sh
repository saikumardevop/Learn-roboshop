source common.sh

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
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app

echo -e "\e[36m>>>>>>>>> Unzip App Content <<<<<<<<<\e[0m"
unzip /tmp/cart.zip

echo -e "\e[36m>>>>>>>>> Install Nodejs Dependencies <<<<<<<<<\e[0m"
npm install

echo -e "\e[36m>>>>>>>>> Create Application Directory <<<<<<<<<\e[0m"
cp /root/roboshop-shell/cart.service /etc/systemd/system/cart.service

echo -e "\e[36m>>>>>>>>> Start Cart Service <<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart
