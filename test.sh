
DEV='https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=!!!测试KEY!!!'
TEST='https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=!!!正式KEY!!!'

while getopts "p:td" opt; do
  case $opt in
    p)
      picture=$OPTARG
      ;;
    t)
      URL=$TEST
      ;;
    d)
      URL=$DEV
      ;;    
    \?)
      echo "Invalid option: -$opt" 
      ;;
  esac
done

echo $picture


MD5=$(md5 $picture|cut -d ' ' -f4)

BASE64=$(base64 $picture)

echo $URL

curl $URL \
   -H 'Content-Type: application/json' \
   -d '{
    "msgtype": "image",
    "image": {
        "base64": "'$BASE64'",
        "md5": "'$MD5'"
    }
   }'

