# dec/10/2024 16:37:35 by RouterOS 6.48.4
# software id = BN0C-WY9F
#
# model = RB952Ui-5ac2nD
# serial number = C55F0B3486A2
/interface pppoe-client
add add-default-route=yes disabled=no interface=ether1 name=pppoe-out1 \
    password=1234 use-peer-dns=yes user=IMR@MASUD
/interface wireless
set [ find default-name=wlan2 ] mode=ap-bridge ssid=MikroTik \
    wireless-protocol=802.11
/interface list
add name=WAN
add name=LAN
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk eap-methods="" \
    management-protection=allowed mode=dynamic-keys name=profile1 \
    supplicant-identity="" wpa-pre-shared-key=pass1234 wpa2-pre-shared-key=\
    pass1234
/interface wireless
set [ find default-name=wlan1 ] mode=ap-bridge security-profile=profile1 \
    ssid=Masud wireless-protocol=802.11
/ip pool
add name=dhcp ranges=192.168.0.2-192.168.0.254
add name=dhcp_pool1 ranges=192.168.0.2-192.168.0.254
add name=pool1 ranges=192.168.100.2-192.168.100.20
add name=dhcp_pool3 ranges=192.168.100.2-192.168.100.254
add name=pppoe-server-pool ranges=10.110.0.2-10.110.0.20
/ip dhcp-server
add address-pool=dhcp_pool1 disabled=no interface=ether2 name=dhcp1
add address-pool=dhcp_pool3 disabled=no interface=wlan1 name=dhcp2
/ppp profile
add dns-server=8.8.8.8 local-address=pppoe-server-pool name=pppoe-profile1 \
    remote-address=pppoe-server-pool
/interface detect-internet
set wan-interface-list=WAN
/interface list member
add list=LAN
add interface=pppoe-out1 list=WAN
/interface pppoe-server server
add default-profile=pppoe-profile1 disabled=no interface=ether3 service-name=\
    pppoe-server
/ip address
add address=192.168.0.1/24 interface=ether2 network=192.168.0.0
add address=192.168.100.1/24 interface=wlan1 network=192.168.100.0
add address=10.110.0.1/24 interface=ether3 network=10.110.0.0
/ip dhcp-client
add disabled=no interface=ether2
/ip dhcp-relay
add dhcp-server=192.168.0.1 disabled=no interface=ether2 name=relay1
/ip dhcp-server network
add address=192.168.0.0/24 gateway=192.168.0.1 netmask=24
add address=192.168.100.0/24 gateway=192.168.100.1
/ip dns
set servers=8.8.8.8
/ip firewall nat
add action=masquerade chain=srcnat out-interface-list=WAN
add action=masquerade chain=srcnat out-interface-list=WAN
add action=masquerade chain=srcnat src-address=10.110.0.0/24
/ppp secret
add name=Masud password=1234 profile=pppoe-profile1
add name=user1 password=1234 profile=pppoe-profile1
/system clock
set time-zone-name=Asia/Dhaka
/system identity
set name=R2
