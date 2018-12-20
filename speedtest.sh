#/bin/bash

speedtest_cli_dir=""

while getopts "s:" optname
do
  case "$optname" in
    "s")
      speedtest_cli_dir=$OPTARG
      ;;
  esac
done


if [ -z "${speedtest_cli_dir}" ]
then
  echo "Give path to https://github.com/sivel/speedtest-cli with param -s"
  exit 1
fi



line=$(${speedtest_cli_dir}/speedtest.py --json | jq -r '[.timestamp, .download, .upload] | @csv' | head -n 1 | sed -es/\"//g )


utcdate=$(echo $line | awk 'BEGIN{FS=","}{print $1}')
down=$(echo $line | awk 'BEGIN{FS=","}{print $2}')
up=$(echo $line | awk 'BEGIN{FS=","}{print $3}')


localdate=$(date --date="TZ=\"UTC\" ${utcdate}" +"%d.%m.%Y %H:%M")

echo $localdate";"$down";"$up
