#!/bin/bash

user_file="users.csv"

register_user() {
    local username="$1"
    local password="$2"
    local email="$3"
    local email_regex="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"

    if ! [[ "$email" =~ $email_regex ]]; then
        echo "Error: Invalid email address ."
        return 1
    fi

    if [[ ! -f "$user_file" ]]; then
        echo "id,username,password_hash,email" > "$user_file"
    fi

    if grep -q ",$username," "$user_file" || grep -q ",$email" "$user_file"; then
        echo "Error: Username or email deja already in use."
        return 1
    fi

<<<<<<< HEAD
=======
    
>>>>>>> 649620de7a371387d288836de26d1ac9440c3401

    while true; do
  	id=$(( RANDOM % 9000 + 1000 ))
	  if ! tail -n +2 "$user_file" | cut -d',' -f1 | grep -q "^$id"; then
    		break
  	  fi
    done


    local password_hash
    password_hash=$(echo -n "$password" | sha256sum | sed 's/ .*//')
    echo "$id,$username,$password_hash,$email" >> "$user_file"
    mesaj="User $username successfully registered with ID: $id"
    echo -e "Subject: Registration complete\n\n$mesaj" | msmtp "$email"	
    echo "User $username succesfully registered with ID: $id"
    mkdir -p "directoare"
    mkdir -p "directoare/$username"
}
prompt_register(){
	read -p "Username: " username
	read  -p "Password: " password
	read -p "Email: " email

register_user "$username" "$password" "$email"
}
prompt_register
