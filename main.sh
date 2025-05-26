#!/bin/bash

read -p "Register (1) | Login (2) | Exit (3)  : " choice

if [[ $choice -eq 1 ]]; then
    ./register.sh

elif [[ $choice -eq 2 ]]; then
    source login.sh
    
elif [[ $choice -eq 3 ]];then
    echo "salut"
else
    echo "salut2"
fi
