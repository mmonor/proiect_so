#!/bin/bash
login_user() {
    local username="$1"
    local password="$2"
    local user_file="users.csv"

    if [[ ! -f "$user_file" ]]; then
        echo "Nu exista utilizatori inregistrati."
        return 1
    fi

    local password_hash
    password_hash=$(echo -n "$password" | sha256sum | awk '{print $1}')

    local user_line
    user_line=$(grep "^.*,${username},${password_hash}," "$user_file")

    if [[ -n "$user_line" ]]; then
        echo "$username."
	cd "directoare/$username"
        return 0
    else
        echo "Username sau parola incorecta."
        return 1
    fi
}
prompt_login(){

    read -p "Username: " username
    read -p "Parolă: " password

   login_user "$username" "$password"

}
prompt_login
