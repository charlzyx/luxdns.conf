rm -rf ./mosdns
rm -rf ./AdguardHome.yaml
rm -rf ./resolve.conf
mkdir -p ./mosdns

cp /etc/mosdns/config.yaml ./mosdns/
cp /etc/mosdns/*.sh ./mosdns/
cp /opt/AdGuardHome/AdGuardHome.yaml ./

git add .
git commit -m 'auto update'
