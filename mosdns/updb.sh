#!/bin/sh

# https://github.com/sbwml/luci-app-mosdns/blob/v5/luci-app-mosdns/root/usr/share/mosdns/mosdns.sh
adlist_update() (
    ad_source="https://raw.githubusercontent.com/v2ray/v2ray-core/master/release/config/geosite.dat"
    # [ "$ad_source" = "geosite.dat" ] || [ -z "$ad_source" ] && exit 0
    AD_TMPDIR=$(mktemp -d) || exit 1
    if echo "$ad_source" | grep -Eq "^https://raw.githubusercontent.com" ; then
        google_status=$(curl -I -4 -m 3 -o /dev/null -s -w %{http_code} http://www.google.com/generate_204)
        [ "$google_status" -ne "204" ] && mirror="https://ghproxy.com/"
    fi
    echo -e "\e[1;32mDownloading $mirror$ad_source\e[0m"
    curl --connect-timeout 60 -m 90 --ipv4 -kfSLo "$AD_TMPDIR/adlist.txt" "$mirror$ad_source"
    if [ $? -ne 0 ]; then
        rm -rf "$AD_TMPDIR"
        exit 1
    else
        \cp "$AD_TMPDIR/adlist.txt" /etc/mosdns/rule/adlist.txt
        mkdir -p /etc/mosdns/rule
        echo "$ad_source" > /etc/mosdns/rule/.ad_source
        rm -rf "$AD_TMPDIR"
    fi
)

geodat_update() (
    TMPDIR=$(mktemp -d) || exit 1
    google_status=$(curl -I -4 -m 3 -o /dev/null -s -w %{http_code} http://www.google.com/generate_204)
    [ "$google_status" -ne "204" ] && mirror="https://ghproxy.com/"
    # geoip.dat - cn-private
    echo -e "\e[1;32mDownloading "$mirror"https://github.com/Loyalsoldier/geoip/releases/latest/download/geoip-only-cn-private.dat\e[0m"
    curl --connect-timeout 60 -m 900 --ipv4 -kfSLo "$TMPDIR/geoip.dat" ""$mirror"https://github.com/Loyalsoldier/geoip/releases/latest/download/geoip-only-cn-private.dat"
    [ $? -ne 0 ] && rm -rf "$TMPDIR" && exit 1
    # checksum - geoip.dat
    echo -e "\e[1;32mDownloading "$mirror"https://github.com/Loyalsoldier/geoip/releases/latest/download/geoip-only-cn-private.dat.sha256sum\e[0m"
    curl --connect-timeout 60 -m 900 --ipv4 -kfSLo "$TMPDIR/geoip.dat.sha256sum" ""$mirror"https://github.com/Loyalsoldier/geoip/releases/latest/download/geoip-only-cn-private.dat.sha256sum"
    [ $? -ne 0 ] && rm -rf "$TMPDIR" && exit 1
    if [ "$(sha256sum "$TMPDIR/geoip.dat" | awk '{print $1}')" != "$(cat "$TMPDIR/geoip.dat.sha256sum" | awk '{print $1}')" ]; then
        echo -e "\e[1;31mgeoip.dat checksum error\e[0m"
        rm -rf "$TMPDIR"
        exit 1
    fi

    # geosite.dat
    echo -e "\e[1;32mDownloading "$mirror"https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat\e[0m"
    curl --connect-timeout 60 -m 900 --ipv4 -kfSLo "$TMPDIR/geosite.dat" ""$mirror"https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"
    [ $? -ne 0 ] && rm -rf "$TMPDIR" && exit 1
    # checksum - geosite.dat
    echo -e "\e[1;32mDownloading "$mirror"https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat.sha256sum\e[0m"
    curl --connect-timeout 60 -m 900 --ipv4 -kfSLo "$TMPDIR/geosite.dat.sha256sum" ""$mirror"https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat.sha256sum"
    [ $? -ne 0 ] && rm -rf "$TMPDIR" && exit 1
    if [ "$(sha256sum "$TMPDIR/geosite.dat" | awk '{print $1}')" != "$(cat "$TMPDIR/geosite.dat.sha256sum" | awk '{print $1}')" ]; then
        echo -e "\e[1;31mgeosite.dat checksum error\e[0m"
        rm -rf "$TMPDIR"
        exit 1
    fi
    rm -rf "$TMPDIR"/*.sha256sum
    cp -f "$TMPDIR"/* /usr/share/v2ray
    rm -rf "$TMPDIR"
)

v2dat_dump() {
    # env
    v2dat_dir=/usr/share/v2ray
    ad_source="geosite.dat"
    configfile="/etc/mosdns/config.yaml"
    mkdir -p /var/mosdns
    rm -f /var/mosdns/geo*.txt
    # default config
    ./v2dat unpack geoip -o /var/mosdns -f cn $v2dat_dir/geoip.dat
    ./v2dat unpack geosite -o /var/mosdns -f cn -f 'geolocation-!cn' $v2dat_dir/geosite.dat
    [ "$ad_source" = "geosite.dat" ] && ./v2dat unpack geosite -o /var/mosdns -f category-ads-all $v2dat_dir/geosite.dat

}
geodat_update && adlist_update && v2dat_dump

