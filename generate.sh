#!/usr/bin/env bash
set -e
function profile(){
	user=$1
	host=$2
	template='{ "Dynamic Profile Parent Name": "DynamicProfileParent", "Tags": [ "SIT.H" ], "Guid": "_HOST", "Badge Text": "_HOST", "Name": "_USER@_HOST", "Initial Text": "ssh _USER@_HOST" },'
	echo "$template" | sed -e "s/_HOST/$host/g;s/_USER/$user/g"
}

# ===================================================================
USERNAME='isaacdong'
HOSTS_FILE='./hosts.txt'
OUTPUT_FILE='./profile.json'
echo -e '{"Profiles": [' > $OUTPUT_FILE
for host in $(cat $HOSTS_FILE); do
	echo "host=$host"
	[[ "x$host" != x ]] && profile $USERNAME $host >> $OUTPUT_FILE
done
echo -e ']}' >> $OUTPUT_FILE
