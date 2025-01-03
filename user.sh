curl -sL https://rpm.nodesource.com/setup_18.x | sudo bash -
dnf install nodejs -y
useradd roboshop
mkdir /app
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip
npm install
cp user.service /etc/systemd/system/user.service
systemctl daemon-reload
systemctl enable user
systemctl start user

cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y
mongo --host mongodb.saikumar22.store </app/schema/user.js