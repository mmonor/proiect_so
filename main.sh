#!/bin/bash

logged_in_users=()
current_user=""
last_user=""
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
    		 exists=false
    		 for user in "${logged_in_users[@]}"; do
      			 if [[ "$username" == "$user" ]]; then
            			exists=true
            			break
      			 fi
    		 done
    		 if ! $exists; then
        		logged_in_users+=("$username")
    		 fi
    		current_user="$username"
    		last_user="$username"
    		echo "Logged in as : $username"
    		;;
                
     
            3)
                echo "Te pup"
                break
                ;;
            *)
                echo "Invalid option."
                ;;
        esac
    else
        echo ""
        echo "Logged in users:  ${logged_in_users[*]}"
        read -p "Raport (1) | Logout (2) | Exit (3): " choice

        case $choice in
            1)
                echo "Generating report..."

		./raport.sh "$last_user" &
                ;;
            2)
                echo "$current_user logged out."
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
                echo "Invalid option."
                ;;
        esac
    fi
done
