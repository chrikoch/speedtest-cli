#/bin/bash

line=$(/home/pi/speedtest-cli-sivel --json | jq -r '[.timestamp, .download, .upload] | @csv' | head -n 1 | sed -es/\"//g )


utcdate=$(echo $line | awk 'BEGIN{FS=","}{print $1}')
down=$(echo $line | awk 'BEGIN{FS=","}{print $2}')
up=$(echo $line | awk 'BEGIN{FS=","}{print $3}')


localdate=$(date --date="TZ=\"UTC\" ${utcdate}" +"%d.%m.%Y %H:%M")

echo $localdate";"$down";"$up
