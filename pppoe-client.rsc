# dec/15/2024 07:02:41 by RouterOS 6.48.4
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
set [ find default-name=wlan1 ] disabled=no mode=ap-bridge security-profile=\
    profile1 ssid=Masud wireless-protocol=802.11
/ip pool
add name=dhcp ranges=10.0.0.2-10.0.0.10
/ip dhcp-server
add address-pool=dhcp disabled=no interface=ether2 name=dhcp1
/interface list member
add interface=pppoe-out1 list=WAN
add list=LAN
/ip address
add address=10.0.0.1/24 interface=ether2 network=10.0.0.0
/ip dhcp-server network
add address=10.0.0.0/24 gateway=10.0.0.1 netmask=24
/ip firewall nat
add action=masquerade chain=srcnat out-interface-list=WAN
/system identity
set name=R2
