#!/bin/bash

if [[ "$(id -u)" != "0" ]]; then
        echo "root privileges are required to run this script."
        exit 1
      fi

if [ $# -lt 1 ] ; then
      echo "Please type the name of the .PFX file"
      exit 1
    fi

certpfx=$1
echo "Extracting the files from $certpfx ..."
echo "Key file in progress..."
openssl pkcs12 -in $certpfx -nocerts -out key.pem -nodes >> /dev/null

if [[ -f key.pem ]]; then
  echo "Cert file in progress..."
  openssl pkcs12 -in $certpfx -nokeys -out cert.pem >> /dev/null
  if [[ -f cert.pem ]]; then
    echo "The process is completed..."
    echo "The new files are located at $(pwd) under the names key.pem and cert.pem"
  fi
else
  echo "There was an issue while trying to extract the file, please contact the admin!"
  exit 1
fi

exit 0
