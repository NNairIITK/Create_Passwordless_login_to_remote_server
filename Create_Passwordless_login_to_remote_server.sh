# Bash script to Create a Passwordless login to Remote Server (SSH) by geneating ssh-key.
#
# Authour  : ANJI BABU KAPAKAYALA
#            BMMG, Curtin University &
#	     IIT KANPUR, INDIA.
#
# Usage    : sh access-free.sh
#
#!/bin/bash
function access_free() {
txtred=$(tput setaf 1)
txtgrn=$(tput setaf 2)
txtylw=$(tput setaf 3)
txtblu=$(tput setaf 4)
txtpur=$(tput setaf 5)
txtcyn=$(tput setaf 6)
txtrst=$(tput sgr0)
COLUMNS=$(tput cols)
center() {
        w=$(( $COLUMNS / 2 - 20 ))
        while IFS= read -r line
        do
                printf "%${w}s %s\n" ' ' "$line"
        done
}

centerwide() {
        w=$(( $COLUMNS / 2 - 30 ))
        while IFS= read -r line
        do
                printf "%${w}s %s\n" ' ' "$line"
        done
}
echo "$txtred   ============================================================$txtrst"
echo "$txtred         Create Password less Login for Remote Server $txtrst" 
echo "$txtred   ============================================================$txtrst"
cd ~
echo ""
#Create authentication ssh-keygen keys on remote server
read -p " $txtpur   Eneter remote server username :$txtrst " user 
read -p " $txtpur   Eneter remote server IP       :$txtrst " serverip 
echo ""
echo "$txtred  [ ****NOTE : If files are already exits, then dont over write. just press n ] $txtrst"
echo ""
ssh-keygen -t rsa
#Create .ssh directory on remote  server
echo;echo " $txtred  Enter remote server Password $txtrst"
ssh $user@$serverip mkdir -p .ssh
#Upload generated public keys to remote server
echo ;echo " $txtred  Enter Password again $txtrst"
cat .ssh/id_rsa.pub|ssh $user@$serverip 'cat >> ~/.ssh/authorized_keys'
echo ""
#Set permissions on remote servers
ssh $user@$serverip "chmod 700 .ssh ; chmod 640 ~/.ssh/authorized_keys"
if [$? == 0]
 then
echo "$txtpur  Congrats....!!!  $txtrst"
echo "$txtpur  You can now login to remote server without password $txtrst"
else
echo " $txtpur Sorry !. Failed to create free Access to $user@$serverip. $txtrst"
echo " $txtpur Contact , System Admin.$txtrst"
echo " $txtpur Bye.! $txtrst"
echo ""
fi
echo " $txtblu             Use this command to Check  $txtrst "
echo " $txtblu   #------------------------------------------#$txtrst"
echo " $txtblu   #      ssh -X $user@$serverip              #$txtrst"
echo " $txtblu   #------------------------------------------#$txtrst"
echo""
echo "$txtred   ============================================================$txtrst"
echo "$txtred                 Written By ANJI BABU KAPAKAYALA $txtrst" 
echo "$txtred   ============================================================$txtrst"
}
access_free
#=======================================================================================#
#       			Written by Anji Babu Kapapakayal	                #
#=======================================================================================#
