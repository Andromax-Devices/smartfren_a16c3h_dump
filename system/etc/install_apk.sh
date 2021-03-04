#!/bin/sh

INSTALL_OK=`cat /data/install_tag`
RESULT=$?
echo $RESULT


echo "start----"
case "$RESULT" in
	"1")
		
echo "install -----"

cp /system/app_back/*.* /data/app/.
chmod -R 644 /data/app/*.*

echo "1" > /data/install_tag

;;
esac

echo "stop----"
INSTALL_OK=`cat /data/install_tag`
RESULT=$?
echo $RESULT

