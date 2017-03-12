su
echo QUIT | openssl s_client -showcerts -connect maven.cyanogenmod.org:443 > ssl.cyanogenmod.org.crt
mv ssl.cyanogenmod.org.crt /usr/local/share/ca-certificates/
update-ca-certificates --fresh
