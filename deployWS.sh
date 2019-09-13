#get the branch name: customer/20190609, release/1.1.14
echo Enter the branch:

read varname

#reset the git
#pull
#checkout to given version
git reset --hard
eval $(ssh-agent -s)
ssh-add ~/.ssh/ipt-mq
git pull
git checkout $varname
git branch -l

#adminportal - install npm packages, build the app
cd adminportal
sudo npm install
sudo npm run build

#customerpage - install npm packages, build the app
cd ../customerpage
sudo npm install
sudo npm run build

#do config changes in the app
cd ../
cp customerpage.config.js customerpage/build/config.js
cp adminportal.config.js adminportal/build/config.js

#remove example config in the app
rm -rf customerpage/build/config.example.js
rm -rf adminportal/build/config.example.js

#file permission
./chmod.js