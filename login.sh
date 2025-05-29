#!/bin/bash
login_user() {
    local username="$1"
    local password="$2"
    local user_file="users.csv"

    if [[ ! -f "$user_file" ]]; then
        echo "There are no registered users."
        return 1
    fi

    local password_hash
    password_hash=$(echo -n "$password" | sha256sum | sed 's/ .*//')

    local user_line
    user_line=$(grep "^.*,${username},${password_hash}," "$user_file")

    if [[ -n "$user_line" ]]; then
        echo "$username"
	cd "directoare/$username"
	bash
        return 0
    else
        echo "Username or password are incorrect."
        return 1
    fi
}
prompt_login(){

    read -p "Username: " username
    read -p "Password: " password

   login_user "$username" "$password"

}
prompt_login
