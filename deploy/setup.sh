#!/usr/bin/env bash
# set -e : If the return code of one command is not 0 and the caller does not check it, the shell script will exit.
set -e
# set -x : Echo command before executuion
set -x

PROJECT_GIT_URL='https://github.com/LscEmitter/remote-rest-api-course.git'

PROJECT_BASE_PATH='/usr/local/apps/profiles-rest-api'

echo "Setup script to install the Django Remote Rest Application on this server"
echo "     From" $PROJECT_GIT_URL
echo "     To  " $PROJECT_BASE_PATH
echo
read  -n 1 -p "Press any key to continue, Ctl-C to cancel"

echo -e "got key\n"
exit

echo "Installing dependencies..."
apt-get update
apt-get install -y python3-dev python3-venv sqlite python-pip supervisor nginx git

# Create project directory
mkdir -p $PROJECT_BASE_PATH
git clone $PROJECT_GIT_URL $PROJECT_BASE_PATH

# Create virtual environment
mkdir -p $PROJECT_BASE_PATH/env
python3 -m venv $PROJECT_BASE_PATH/env
. $PROJECT_BASE_PATH/env/bin/activate

# Install python packages
$PROJECT_BASE_PATH/env/bin/pip install -r $PROJECT_BASE_PATH/requirements.txt
$PROJECT_BASE_PATH/env/bin/pip install uwsgi==2.0.18

# Run migrations and collectstatic
cd $PROJECT_BASE_PATH
$PROJECT_BASE_PATH/env/bin/python manage.py migrate
$PROJECT_BASE_PATH/env/bin/python manage.py collectstatic --noinput

# Configure supervisor
cp $PROJECT_BASE_PATH/deploy/supervisor_profiles_api.conf /etc/supervisor/conf.d/profiles_api.conf
supervisorctl reread
supervisorctl update
supervisorctl restart profiles_api

# Configure nginx
cp $PROJECT_BASE_PATH/deploy/nginx_profiles_api.conf /etc/nginx/sites-available/profiles_api.conf
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/profiles_api.conf /etc/nginx/sites-enabled/profiles_api.conf
systemctl restart nginx.service

echo "DONE! :)"
