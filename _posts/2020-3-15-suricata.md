---
title: Setup Lab Monitoring Serangan Jaringan dan Ethical Hacking dengan Suricata
date: 2020-3-15T09:18:27+07:00
categories:
  - blog
  - network
  - monitoring
tags:
  - tutorial
  - vulnhub
  - suricata
---

# Setup Lab Monitoring Serangan Jaringan dan Ethical Hacking dengan Suricata 

## Prerequisites
1. Oracle Virtualbox / VMWare
2. VM Vulnhub
3. Ubuntu Server Bionic Beaver (18.0x) sebagai IDS sekaligus Firewall

Kali ini saya akan membuat panduan untuk monitoring serangan jaringan dengan Suricata dan VM Vulnhub. Kita akan menggunakan OS Ubuntu Server sebagai IDS (host si Suricata) sekaligus Firewall. Apabila Anda memiliki PC dengan spesifikasi yang mumpuni mungkin bisa diganti dengan NSM Suite seperti SecurityOnion atau Pfsense.

## Topologi
Nantinya si Ubuntu akan kita buat menjadi gateway antara Host OS (Kali Linux) dengan VM Vulnhub yang akan dipentest. Maka dari itu topologi yang saya gunakan adalah:

![Topologi](/assets/images/suricata/topologi2.png)

## Konfigurasi Ubuntu
1 adapter Host-only sebagai penghubung antara Host OS dengan IDS, 1 adapter Internal untuk penghubung IDS dengan VM dan 1 adapter NAT untuk koneksi Internet si Ubuntu yang hanya kita gunakan saat instalasi atau update rules saja, saya gunakan NAT di adapter pertama (enp0s3/eth0), Host-only di interface kedua (enp0s8/eth1), dan Internal Adapter di interface ketiga (enp0s9/eth2).

Catatan: pastikan untuk selalu menggunakan `sudo` karena semua langkah dibawah memerlukan akses root. Misal untuk mengedit/membuat file `sudo nano file.txt` atu `sudo vim file.txt`.

### Konfigurasi interface 
1. Sesuaikan alamat IP, buat file `/etc/netplan/99_config.yaml` dan isi dengan baris dibawah.
```
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: true
    enp0s8:
      addresses: 
        - 192.168.1.1/30
    enp0s9:
      addresses: 
        - 192.168.0.1/30
```

### Konfigurasi DHCP 
Untuk jaringan ke VM Vulnhub karena beberapa VM memerlukan DHCP server untuk dapat terhubung ke jaringan.
1. `sudo apt install isc-dhcp-server`
2. Tambahkan `enp0s9` di `/etc/default/isc-dhcp-server` bagian INTERFACESv4
3. Konfigurasi DHCP di `/etc/dhcp/dhcpd.conf`
```
subnet 192.168.0.0 netmask 255.255.255.252 {
  range 192.168.0.2;
  option routers 192.168.0.1;
  option broadcast-address 192.168.0.3;
  default-lease-time 600;
  max-lease-time 7200;
}
```

### IP Forwarding
Agar trafik dapat di forward ke network lain
1. Ubah baris ipv4.forwarding di`/etc/sysctl.conf`
```
net.ipv4.ip_forward = 1
```
2. Ketikkan perintah `sudo iptables -t nat -A POSTROUTING -o enp0s9 -j MASQUERADE`


### Instalasi Suricata
1. Masuk ke VM Ubuntu (lebih baik lewat SSH karena memudahkan copy paste)
2. Konfigurasi repo di /etc/apt/sources.list lalu jalankan `sudo apt update`
3. Install prerequisites Suricata
```
sudo apt -y install libpcre3 libpcre3-dbg libpcre3-dev \
build-essential autoconf automake libtool libpcap-dev libnet1-dev \
libyaml-0-2 libyaml-dev zlib1g zlib1g-dev libmagic-dev libcap-ng-dev \
libjansson-dev pkg-config rustc cargo
```
4. Download Suricata
```
sudo add-apt-repository ppa:oisf/suricata-stable
sudo apt-get update
sudo apt-get install suricata
```

### Konfigurasi Rules dan Monitoring Suricata
Sekarang kita akan mengkonfigurasi rules/signature yang akan digunakan Suricata untuk mendeteksi serangan.


#### Konfigurasi Monitoring Dasar
1. Buka file `/etc/suricata/suricata/yaml`
2. Sesuaikan network lokal / HOME_NET.
```
   HOME_NET: "[192.168.0.0/30, 192.168.1.0/30]"
```
3. Cari `default-log-dir` dan sesuaikan
```
default-log-dir: /var/log/suricata/
```
4. Cari `af-packet` dan sesuaikan
```
  - interface: enp0s8
  - cluster-id: 99
  - cluster-type: cluster_flow
  - defrag: yes
  - use-mmap: yes
  - tpacket-v3: yes
```

#### Instalasi Ruleset Emerging Threats
Instalasi dan update rules di Suricata sebenarnya bisa dilakukan secara otomatis lewat `suricata-update`, namun kali ini kita akan menggunakan cara manual untuk konfigurasi rulesnya.
1. Unduh ruleset Emerging Threats
```
wget https://rules.emergingthreats.net/open/suricata-5.0/emerging.rules.tar.gz
tar xzvf emerging.rules.tar.gz
```
2. Copy isi dari hasil extract ke folder rules Suricata `sudo cp rules/* /etc/suricata/rules/`
Selanjutnya kita akan menerapkan ruleset dari Emerging Threats untuk digunakan oleh Suricata.
1. Ketikkan perintah `ls /etc/suricata/rules/ | grep .rules | sed 's/^/  - /' > rule-files.txt` untuk membuat isi YAML array berupa rules yang akan digunakan Suricata.
2. Edit `/etc/suricata/suricata.yaml`
3. Cari `classification.config` lalu sesuaikan
```
classification-file: /etc/suricata/rules/classification.config
```
4. Cari `rule-files`, tambahkan tanda pagar di baris `suricata.rules` lalu copy isi rule-files.txt yang kita buat tadi kedalam array `rule-files` disini.
```
rule-files:
#  - suricata.rules
  - emerging-activex.rules
  - emerging-adware_pup.rules
  - emerging-attack_response.rules
  - emerging-chat.rules
  - emerging-coinminer.rules
  - emerging-current_events.rules
  - emerging-deleted.rules
  - emerging-dns.rules
  - emerging-dos.rules
  - emerging-exploit_kit.rules
  - emerging-exploit.rules
  - emerging-ftp.rules
  - emerging-games.rules
  - emerging-hunting.rules
  - emerging-icmp_info.rules
  - emerging-icmp.rules
  - emerging-imap.rules
  - emerging-inappropriate.rules
  - emerging-info.rules
  - emerging-ja3.rules
  - emerging-malware.rules
  - emerging-misc.rules
  - emerging-mobile_malware.rules
  - emerging-netbios.rules
  - emerging-p2p.rules
  - emerging-phishing.rules
  - emerging-policy.rules
  - emerging-pop3.rules
  - emerging-rpc.rules
  - emerging-scada.rules
  - emerging-scan.rules
  - emerging-shellcode.rules
  - emerging-smtp.rules
  - emerging-snmp.rules
  - emerging-sql.rules
  - emerging-telnet.rules
  - emerging-tftp.rules
  - emerging-user_agents.rules
  - emerging-voip.rules
  - emerging-web_client.rules
  - emerging-web_server.rules
  - emerging-web_specific_apps.rules
```
5. Test konfigurasi dengan perintah `sudo suricata -T`. Pastikan output terakhirnya berupa `Configuration provided was successfully loaded`.

### Testing
Apabila konfigurasi dasar rules dan monitoring sudah selesai maka kita dapat melakukan testing dengan cara melakukan scan Nmap ke IDS/VM Vulnhub yang terhubung dengan IDS.
Kali ini saya melakukan scanning dari Host OS (Kali) ke VM Vulnhub ([Bytesec]([https://zaidanr.github.io/blog/os-bytesec/](https://zaidanr.github.io/blog/os-bytesec/))).
1. Jalankan Suricata `sudo suricata -c /etc/suricata/suricata.yaml -i enp0s8 &` (perintah & untuk menjalankan di background)
2. Tunggu sampai pesan `engine started` lalu klik enter untuk kembali ke prompt
3. Monitor log secara real-time dengan perintah `sudo tail -f /var/log/suricata/fast.log`
4. Lalu dari Host OS ketikkan perintah `nmap -A -p- 192.168.0.2`
5. Apabila rules sudah terpasang dengan benar maka akan Suricata akan memunculkan alert seperti dibawah
```
03/15/2020-07:14:31.237630  [**] [1:2225005:1] SURICATA SMB malformed request dialects [**] [Classification: Generic Protocol Command Decode] [Priority: 3] {TCP} 192.168.1.2:45714 -> 192.168.0.2:445
03/15/2020-08:30:07.021988  [**] [1:2024364:3] ET SCAN Possible Nmap User-Agent Observed [**] [Classification: Web Application Attack] [Priority: 1] {TCP} 192.168.1.2:60044 -> 192.168.0.2:80
03/15/2020-08:30:07.022297  [**] [1:2024364:3] ET SCAN Possible Nmap User-Agent Observed [**] [Classification: Web Application Attack] [Priority: 1] {TCP} 192.168.1.2:60056 -> 192.168.0.2:80
03/15/2020-08:30:07.022456  [**] [1:2024364:3] ET SCAN Possible Nmap User-Agent Observed [**] [Classification: Web Application Attack] [Priority: 1] {TCP} 192.168.1.2:60046 -> 192.168.0.2:80
03/15/2020-08:30:07.022711  [**] [1:2024364:3] ET SCAN Possible Nmap User-Agent Observed [**] [Classification: Web Application Attack] [Priority: 1] {TCP} 192.168.1.2:60058 -> 192.168.0.2:80
03/15/2020-08:30:07.022987  [**] [1:2024364:3] ET SCAN Possible Nmap User-Agent Observed [**] [Classification: Web Application Attack] [Priority: 1] {TCP} 192.168.1.2:60060 -> 192.168.0.2:80
03/15/2020-08:30:07.023141  [**] [1:2024364:3] ET SCAN Possible Nmap User-Agent Observed [**] [Classification: Web Application Attack] [Priority: 1] {TCP} 192.168.1.2:60062 -> 192.168.0.2:80
```
6. Untuk mematikan monitoring Suricata ketik `jobs`
7. `fg 1` untuk kembali ke prompt Suricata
8. Ctrl+C


Sekian artikel kali ini, mungkin next bakal nyoba ELK Stack buat log monitoring & visualization Suricata. 

Thanks and kalo ada yang gak paham/error feel free to ask me..

## Reference 
[https://suricata.readthedocs.io/en/suricata-5.0.2/](https://suricata.readthedocs.io/en/suricata-5.0.2/)
[https://help.ubuntu.com/lts/serverguide/serverguide.pdf](https://help.ubuntu.com/lts/serverguide/serverguide.pdf)
[https://redmine.openinfosecfoundation.org/projects/suricata/wiki/Rule_Management_with_Oinkmaster](https://redmine.openinfosecfoundation.org/projects/suricata/wiki/Rule_Management_with_Oinkmaster)
