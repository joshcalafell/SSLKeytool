#!/bin/bash
# Filname: SSLKeyTool.sh
# Author: Joshua Michael Waggoner
# Git-Hub: github.com/rabbitfighter81/SSLKeytool
# Purpose: keytool to create a simple JKS keystore suitable for use with JSSE. 

# Get the username to use with keytool
echo "Welcome to keystore generator..."

echo "Type the name you wish to use with keytool and press [ENTER]:"

read username

echo "You chose '$username'"

echo="Please enter your choice: "

options=(
	"Create new keystore" 
	"Examine the keystore" 
	"Export and examine the self-signed certificate" 
	"Import the certificate into a new truststore" 
	"Examine the truststore" 
	"Add to a keystore"
	"Quit"
	)

select opt in "${options[@]}"

do
    case $opt in

    	###########################################################################################
        ##                                     KEY TOOLS                                         ##
        ###########################################################################################

    	# 1) Create a new keystore and self-signed certificate with corresponding 
		# public/private keys.
        "Create new keystore")

            echo "you chose \"Create new keystore\""

			keytool -genkeypair -alias $username -keyalg RSA \
			-validity 7 -keystore keystore
        ;;

        # 2) Examine the keystore
        "Examine the keystore")

            echo "You chose \"Examine the keystore\""

			keytool -list -v -keystore keystore
        ;;

        # 3) Export and examine the self-signed certificate.
        "Export and examine the self-signed certificate")

            echo "You chose \"Export and examine the self-signed certificate\""

			keytool -export -alias $username -keystore keystore -rfc \
			-file $username.cer
        ;;

        # 4) Import the certificate into a new truststore.
        "Import the certificate into a new truststore")

	        echo "You chose \"Import the certificate into a new truststore\""

			keytool -import -alias $username -file $username.cer \
			-keystore truststore
        ;;

        # 5) Examine the truststore.
        "Examine the truststore")

	        echo "You chose \"Examine the truststore\""

			keytool -list -v -keystore truststore
        ;;

        # 6) Add to keystore
        "Add to a keystore")

			echo "You chose \"Add to keystore of your choosing\""

			echo "Please enter the path to your computer's \"cacerts\" file"
				 #"This is usually found in /usr/lib/jvm/<java version folder>
				 #/jre/lib/security\" or something similar" -> /etc/ssl/certs/java/cacerts

			read path

			sudo keytool -import -file $username.cer -alias "${username}" -keystore "${path}"
		;;

	# Quit
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done











