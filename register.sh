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

    if grep -q ",$username," "$user_file" || grep -q ",$email$" "$user_file"; then
        echo "Eroare: Username sau email deja folosit."
        return 1
    fi

    local id=$(( RANDOM % 9000 + 1000 ))

    local password_hash
    password_hash=$(echo -n "$password" | sha256sum | sed 's/ .*//')
    echo "$id,$username,$password_hash,$email" >> "$user_file"
    echo "User $username succesfully registered with ID: $id"
    mkdir -p "directoare"
    mkdir -p "directoare/$username"
}
prompt_register(){
	read -p "Username: " username
	read  -p "Password: " password
	echo
	read -p "Email: " email

register_user "$username" "$password" "$email"
}
prompt_register
