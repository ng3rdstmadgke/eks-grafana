for i in $(seq 1 25); do
  success=$(MYSQL_PWD=$MYSQL_PASSWORD mysql -u $MYSQL_USER -h $MYSQL_HOST -P 3306 $MYSQL_DATABASE -e "SELECT 'success'" >/dev/null 2>&1; echo $?)
  if [ "$success" = "0" ]; then
    echo "success!!"
    exit
  else
    echo "mysql booting..."
  fi
  sleep 1
done
echo "failed..."
exit 1