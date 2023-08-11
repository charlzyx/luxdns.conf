rm -rf ./mosdns
rm -rf ./AdguardHome.yaml
mkdir -p ./mosdns

cp /etc/mosdns/config.yaml ./mosdns/
cp /etc/mosdns/*.sh ./mosdns/
cp /opt/AdGuardHome/AdGuardHome.yaml ./
cp ~/.zshrc ./


git add .
git commit -m 'auto update'
