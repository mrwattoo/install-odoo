# install-odoo



## Installation procedure

##### 1. Download the script:
```
sudo wget https://raw.githubusercontent.com/mrwattoo/install-odoo/main/odoo13.sh
```
```
sudo wget https://raw.githubusercontent.com/mrwattoo/install-odoo/main/odoo15.sh
```
```
sudo wget https://raw.githubusercontent.com/mrwattoo/install-odoo/main/odoo16.sh
```
```
sudo wget https://raw.githubusercontent.com/mrwattoo/install-odoo/main/odoo17.sh
```
```
sudo wget https://raw.githubusercontent.com/mrwattoo/install-odoo/main/odoo18.sh
```



#### 2. Make the script executable
```
sudo chmod +x odoo13.sh
```
```
sudo chmod +x odoo15.sh
```
```
sudo chmod +x odoo16.sh
```
```
sudo chmod +x odoo17.sh
```
```
sudo chmod +x odoo18.sh
```
##### 3. Execute the script:
```
sudo ./odoo13.sh
```
```
sudo ./odoo15.sh
```
```
sudo ./odoo16.sh
```
```
sudo ./odoo17.sh
```
```
sudo ./odoo18.sh
```

## Minimal server requirements
While technically you can run an Odoo instance on 1GB (1024MB) of RAM it is absolutely not advised. A Linux instance typically uses 300MB-500MB and the rest has to be split among Odoo, postgreSQL and others. If you install an Odoo you should make sure to use at least 2GB of RAM. This script might fail with less resources too.

