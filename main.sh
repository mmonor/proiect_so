#!/bin/bash

logged_in_users=()
current_user=""

while true; do
    if [[ -z "$current_user" ]]; then
        echo ""
        read -p "Register (1) | Login (2) | Exit (3): " choice

        case $choice in
            1)
                ./register.sh
                ;;
            2)
                username=$(source login.sh)
                if [[ -n "$username" ]]; then
                    already_logged_in=false
                    for user in "${logged_in_users[@]}"; do
                        if [[ "$user" == "$username" ]]; then
                            already_logged_in=true
                            break
                        fi
                    done

                    if $already_logged_in; then
                        echo "Utilizatorul '$username' este deja logat."
                    else
                        logged_in_users+=("$username")
                        current_user="$username"
                        echo "Utilizator logat: $username"
                    fi
                fi
                ;;
            3)
                echo "Te pup"
                break
                ;;
            *)
                echo "Opțiune invalidă."
                ;;
        esac
    else
        echo ""
        echo "Utilizatori logați: ${logged_in_users[*]}"
        read -p "Raport (1) | Logout (2) | Exit (3): " choice

        case $choice in
            1)
                echo "Afișare raport (de implementat)"
                ;;
            2)
                echo "$current_user s-a delogat."
                for i in "${!logged_in_users[@]}"; do
                    if [[ "${logged_in_users[$i]}" == "$current_user" ]]; then
                        unset 'logged_in_users[i]'
                        break
                    fi
                done
                current_user=""
                ;;
            3)
                current_user=""
                ;;
            *)
                echo "Opțiune invalidă."
                ;;
        esac
    fi
done
