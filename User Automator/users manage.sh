#!/bin/bash

# Function to Create Users and Set Permissions
create_users() {
    echo "=== Create 3 Users & Set Permissions ==="
    
    folder="project_folder"
    mkdir -p $folder

    for (( i=1; i<=3; i++ ))
    do
        read -p "Enter username: " username

        if id "$username" &>/dev/null; then
            echo "Error: User '$username' already exists."
        else
            sudo adduser "$username"
            
            if [ $i -eq 3 ]; then
                sudo setfacl -m u:$username:rwx $folder
                echo "User '$username' created with FULL (rwx) permissions."
            else
                sudo setfacl -m u:$username:rw $folder
                echo "User '$username' created with READ/WRITE (rw) permissions."
            fi
        fi
    done
}

# Function to Delete User
delete_user() {
    echo "=== Delete User ==="
    read -p "Enter username to delete: " username

    if id "$username" &>/dev/null; then
        sudo userdel -r "$username"
        echo "User '$username' deleted successfully."
    else
        echo "Error: User '$username' does not exist."
    fi
}

# Function to Check User Existence
check_user() {
    echo "=== Check User ==="
    read -p "Enter username to check: " username

    if id "$username" &>/dev/null; then
        echo "Result: User '$username' EXISTS."
    else
        echo "Result: User '$username' DOES NOT EXIST."
    fi
}

# Main Menu
while true
do
    echo ""
    echo "=============================="
    echo "   USER MANAGEMENT TOOLKIT    "
    echo "=============================="
    echo "1. Create Users & Set Permissions"
    echo "2. Delete User"
    echo "3. Check User Existence"
    echo "4. Exit"
    echo "=============================="
    read -p "Enter choice: " choice

    case $choice in
        1) create_users ;;
        2) delete_user ;;
        3) check_user ;;
        4) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option." ;;
    esac
done