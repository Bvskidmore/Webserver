#!/bin/bash

sudo yum update -y
sudo amazon-linux-extras install nginx1.12 -y
sudo chkconfig nginx on
sudo aws s3 cp s3://skid8956-assignment-webserver/index.html /usr/share/nginx/html/index.html
sudo service nginx start

# assign variables
ACTION=${1}
VERSION="1.0.0"

function remove() {
sudo service nginx stop
rm "usr/share/nginx/html/index.html"
sudo yum remove nginx -y
}

function version() {

echo VERSION $VERSION

}

function display_help() {

cat << EOF
Usage: ${0} {-r|--remove|-h|--help|-v|--version} <filename>
OPTIONS:
	-r | --remove Nginx Service
	-v | --verison Show Version
	-h | --help Display the command help
	
Examples:
	Display help:
		$ ${0} -h
	Remove Nginx:
		$ ${0} -r
	Show Version:
		$ ${0} -v
EOF
}

case "$ACTION" in
	-h|--help)
		display_help
		;;
	-r|--remove)
		remove
		;;
	-v|--version)
		version
		;;
	*)
	echo "Usage ${0} {-r|-h|-v}"
	exit 1
esac
