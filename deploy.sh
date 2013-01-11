#!/usr/bin/env sh

wget http://code.google.com/p/goagent/ -O homepage.html
addr=`python get_url.py homepage.html`
wget $addr -O goagent.zip
rm homepage.html

if [ ! -e resources/last_zip_md5 -a -d archives -a "`ls archives | grep '\.zip'`" != "" ]; then
    last_zip=`ls -t archives | grep '\.zip' | head -1`
    echo -n `md5sum archives/$last_zip | cut -d ' ' -f 1` >resources/last_zip_md5
fi

zip_md5=`md5sum goagent.zip | cut -d ' ' -f 1`
if [ ! -e resources/last_zip_md5 -o "$zip_md5" != "`cat resources/last_zip_md5`" ]; then
    mkdir -p archives
    date=`date +%F`
    cp goagent.zip archives/$date.zip

    mkdir -p unzipped
    unzip -d unzipped goagent.zip
    deploy_dir=`find unzipped -name server -type d`
    if [ "$deploy_dir" != "" -a -f $deploy_dir/uploader.zip -a -f resources/app_list ]; then
        cp resources/appcfg_cookies $deploy_dir/.appcfg_cookies
        cwd=`pwd`
        cd $deploy_dir
        while read app_id; do
            echo "$app_id" | python uploader.zip
        done < resources/app_list
        cd $cwd
    fi
    rm -rf unzipped

    echo -n `md5sum goagent.zip | cut -d ' ' -f 1` >resources/last_zip_md5
fi
rm goagent.zip
