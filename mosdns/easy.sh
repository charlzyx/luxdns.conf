mkdir -p /etc/mosdns/rule

curl https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-list.txt > /etc/mosdns/rule/direct-list.txt && \
curl https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/apple-cn.txt > /etc/mosdns/rule/apple-cn.txt && \
curl https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/google-cn.txt > /etc/mosdns/rule/google-cn.txt && \
curl https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt > /etc/mosdns/rule/proxy-list.txt && \
curl https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/gfw.txt > /etc/mosdns/rule/gfw.txt && \
curl https://raw.githubusercontent.com/Hackl0us/GeoIP2-CN/release/CN-ip-cidr.txt > /etc/mosdns/rule/CN-ip-cidr.txt && \
touch /etc/mosdns/rule/force-nocn.txt && \
touch /etc/mosdns/rule/force-cn.txt

