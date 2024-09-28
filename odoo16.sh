


echo -e "\n Installaion of ODOO16 Process Start\n"
OE_USER="odoo16"
echo -e "\n---- Update Server ----\n"

sudo apt update

echo -e "\n---- Downloding and Installing Python and  Necessary Files----\n"

sudo apt install git python3-pip build-essential wget python3-dev python3-venv python3-wheel libfreetype6-dev libxml2-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools node-less libjpeg-dev zlib1g-dev libpq-dev libxslt1-dev libldap2-dev libtiff5-dev libjpeg8-dev libopenjp2-7-dev liblcms2-dev libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev -y

echo -e "\n---- Creating User ----\n"
sudo useradd -m -d /opt/${OE_USER} -U -r -s /bin/bash $OE_USER

echo -e "\n---- Installing Postgres ----\n"

sudo apt install postgresql -y

echo -e "\n---- Creating Postgres User ----\n"

sudo su - postgres -c "createuser -s ${OE_USER}"

echo -e "\n---- Installing wkhtmltopdf ----\n"

if [ $(lsb_release -r -s) == "22.04" ]; then
    WKHTMLTOX_X64="https://packages.ubuntu.com/jammy/wkhtmltopdf"
    WKHTMLTOX_X32="https://packages.ubuntu.com/jammy/wkhtmltopdf"
    #No Same link works for both 64 and 32-bit on Ubuntu 22.04
else
    # For older versions of Ubuntu
    WKHTMLTOX_X64="https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.$(lsb_release -c -s)_amd64.deb"
    WKHTMLTOX_X32="https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.$(lsb_release -c -s)_i386.deb"
fi

echo -e "\n---- Installing ODOO ----\n"

sudo su ${OE_USER} -c "git clone https://www.github.com/odoo/odoo --depth 1 --branch 16.0 /opt/${OE_USER}/odoo"
sudo chmod -R 777 /opt
echo -e "\n---- Creating odoo-venv and installing reqquirement.txt ----\n"

sudo su ${OE_USER} -c"mkdir /opt/$${OE_USER}/odoo-custom-addons; python3 -m venv /opt/${OE_USER}/odoo-venv; source /opt/${OE_USER}/odoo-venv/bin/activate; pip3 install wheel; pip3 install -r /opt/${OE_USER}/odoo/requirements.txt; deactivate;"


echo -e "\n---- Creating Configration File ----\n"



sudo touch /etc/${OE_USER}.conf

sudo su root -c "printf '[options]\n' >> /etc/${OE_USER}.conf"
sudo su root -c "printf 'admin_passwd = Allahis1\n' >> /etc/${OE_USER}.conf"
sudo su root -c "printf 'db_user = ${OE_USER}\n' >> /etc/${OE_USER}.conf"
sudo su root -c "printf 'db_password = False\n' >> /etc/${OE_USER}.conf"
sudo su root -c "printf 'addons_path = /opt/${OE_USER}/odoo/addons,/opt/${OE_USER}/odoo-custom-addons\n' >> /etc/${OE_USER}.conf"
sudo su root -c "printf 'xmlrpc_port = 1600\n' >> /etc/${OE_USER}.conf"
sudo su root -c "printf 'logfile = /var/log/${OE_USER}/${OE_USER}.log\n' >> /etc/${OE_USER}.conf"

echo -e "\n---- Creating Log Directory ----\n"

sudo mkdir /var/log/${OE_USER}

echo -e "\n---- Creating Log File ----\n"

sudo touch /var/log/${OE_USER}/${OE_USER}.log
sudo chmod -R 777 /var/log/${OE_USER}




echo -e "\n---- Creating Service File ----\n"


sudo touch /etc/systemd/system/${OE_USER}.service

sudo su root -c "printf '[Unit]\n' >> /etc/systemd/system/${OE_USER}.service"
sudo su root -c "printf 'Description=${OE_USER}\n' >> /etc/systemd/system/${OE_USER}.service"
sudo su root -c "printf 'Requires=postgresql.service\n' >> /etc/systemd/system/${OE_USER}.service"
sudo su root -c "printf 'After=network.target postgresql.service\n' >> /etc/systemd/system/${OE_USER}.service"

sudo su root -c "printf '[Service]\n' >> /etc/systemd/system/${OE_USER}.service"
sudo su root -c "printf 'Type=simple\n' >> /etc/systemd/system/${OE_USER}.service"
sudo su root -c "printf 'SyslogIdentifier=${OE_USER}\n' >> /etc/systemd/system/${OE_USER}.service"
sudo su root -c "printf 'PermissionsStartOnly=true\n' >> /etc/systemd/system/${OE_USER}.service"
sudo su root -c "printf 'User=${OE_USER}\n' >> /etc/systemd/system/${OE_USER}.service"
sudo su root -c "printf 'Group=${OE_USER}\n' >> /etc/systemd/system/${OE_USER}.service"
sudo su root -c "printf 'ExecStart=/opt/${OE_USER}/odoo-venv/bin/python3 /opt/${OE_USER}/odoo/odoo-bin -c /etc/${OE_USER}.conf\n' >> /etc/systemd/system/${OE_USER}.service"
sudo su root -c "printf 'StandardOutput=journal+console\n' >> /etc/systemd/system/${OE_USER}.service"

sudo su root -c "printf '[Install]\n' >> /etc/systemd/system/${OE_USER}.service"
sudo su root -c "printf 'WantedBy=multi-user.target\n' >> /etc/systemd/system/${OE_USER}.service"



sudo chmod -R 777 /opt

sudo systemctl daemon-reload
sudo systemctl restart ${OE_USER}.service
sudo systemctl status ${OE_USER}.service


