# oct/29/2024 21:23:45 by RouterOS 6.48.4
# software id = BN0C-WY9F
#
# model = RB952Ui-5ac2nD
# serial number = C55F0B3486A2
/interface bridge
add name=bridge1
/interface ethernet
set [ find default-name=ether1 ] name=ether1-LAN
set [ find default-name=ether2 ] name=ether2-LAN
set [ find default-name=ether3 ] name=ether3-LAN
set [ find default-name=ether4 ] name=ether4-LAN
set [ find default-name=ether5 ] name=ether5-Manager
/interface wireless
set [ find default-name=wlan2 ] ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk eap-methods="" \
    management-protection=allowed mode=dynamic-keys name=Wi-Fi_passwd \
    supplicant-identity="" wpa-pre-shared-key=emran6267 wpa2-pre-shared-key=\
    emran6267
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n disabled=no frequency=2432 \
    name=wlan1-Wi-Fi security-profile=Wi-Fi_passwd ssid="Bachelor_Point 2"
/ip pool
add name=dhcp_pool0 ranges=10.10.70.2-10.10.70.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=bridge1 lease-time=2d10m \
    name=dhcp1
/interface bridge port
add bridge=bridge1 interface=ether1-LAN multicast-router=disabled
add bridge=bridge1 interface=ether2-LAN multicast-router=disabled
add bridge=bridge1 interface=ether3-LAN multicast-router=disabled
add bridge=bridge1 interface=ether4-LAN multicast-router=disabled
/ip address
add address=10.10.90.1/24 interface=wlan1-Wi-Fi network=10.10.90.0
add address=10.10.70.1/24 interface=bridge1 network=10.10.70.0
add address=10.0.0.1/24 disabled=yes interface=bridge1 network=10.0.0.0
add address=10.0.1.0/24 disabled=yes interface=wlan1-Wi-Fi network=10.0.1.0
/ip dhcp-client
add disabled=no interface=wlan1-Wi-Fi
/ip dhcp-server network
add address=10.10.70.0/24 gateway=10.10.70.1
/ip dns
set servers=8.8.8.8,10.10.70.1,10.10.90.1
/ip firewall nat
add action=masquerade chain=srcnat out-interface=wlan1-Wi-Fi
/system clock
set time-zone-name=Asia/Dhaka
/system identity
set name=R2
