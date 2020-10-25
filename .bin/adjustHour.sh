TIMEDATECTL=$(timedatectl | grep "Local time")
IFS=' ' read -r -a array <<< "$TIMEDATECTL"
DATE=${array[3]}
OLDTIME=${array[4]}
NEWHOUR=$(( ${OLDTIME:0:2} + $1 ))
NEWTIME="${NEWHOUR}${OLDTIME:2:6}"
sudo timedatectl set-time "${DATE} ${NEWTIME}"