---
title: "Pengenalan Kubernetes [1/3]"
date: 2020-1-13T21:14:02+07:00
categories:
  - blog
  - devops
tags:
  - devops
  - kubernetes
  - tutorial
---

# KUBERNETES
**Kubernetes** atau biasa disingkat **k8s** adalah sistem container orchestration open-source untuk mengautomasi proses deployment, scaling, dan manajemen suatu aplikasi. Kubernetes dapat berjalan dengan container system seperti Docker, Vagrant atau rkt.  

Container orchestration adalah sebuah proses mengelola lifecycle suatu sistem container, terutama dalam sistem yang kompleks dan dinamis. Tim developer menggunakan container 

# Komponen Kubernetes

## Controllers
Analogikan sistem sebuah AC, didalam AC terdapat thermostat yang mengatur suhu AC yang sudah ditentukan lewat remote. Saat kita mengatur suhu AC yang diinginkan lewat remote, thermostat di AC akan memonitor dan mengatur suhu dengan cara mempercepat putaran kipas atau memperkuat aliran freon.  

Thermostat dapat dianggap sebagai _controller_, sedangkan suhu yang dikehendaki dapat disebut sebagai _desired state_. Controller dalam Kubernetes mengontrol dan mengawasi _state_ (keadaan) dari suatu Cluster agar selalu mencapai _desired state_. Controller membuat perintah untuk menyesuaikan _state_ cluster apabila diperlukan untuk mencapai _desired state_.  

## Cluster
Cluster adalah suatu sistem Kubernetes yang terdiri dari kumpulan **worker node** dan sebuah **master node**.  

**Master** adalah sebuah node yang bertanggung jawab mengontrol sebuah Cluster.  

Sedangkan **worker node** adalah VM atau physical computer yang bekerja sebagai worker machine dalam sebuah Cluster Kubernetes. Worker node dapat menjadi tempat untuk melakukan deployment sekaligus integration. Tiap node dalam kluster menjalankan service Kubelet, yaitu agent untuk mengontrol node dan berkomunikasi dengan master node. Tiap node juga harus memiliki sebuah tools untuk mengatur container seperti Docker atau rkt.  

Saat aplikasi di deploy ke Kubernetes, master membuat application container kemudian menyusun dan memerintahkan container tersebut untuk dijalankan di dalam suatu  node dalam Cluster.

Untuk membuat Kubernetes Cluster dapat menggunakan `minikube`. Minikube merupakan tools untuk menjalankan Kubernetes dalam sistem lokal.

## Pods
Pod merupakan unit eksekusi sekaligus unit paling dasar didalam sistem Kubernetes. Sebuah Pod mereprentasikan proses yang berjalan dalam suatu Cluster.  

Sebuah Pod membungkus satu atau lebih application container, storage resources (penyimpanan), network IP, dan parameter lain yang mengatur bagaimana container dijalankan. Secara sederhana Pod adalah 
suatu _instance_ terkecil dalam Kubernetes Cluster, yang dapat berisi satu atau lebih container yang saling menggunakan sumber daya secara bersama-sama.  

## Deployments

!(2.svg)[kubernetes-deployment)![Kubernetes Cluster](/assets/images/Kubernetes-Intro-1/deployment.svg)  

Deployment digunakan untuk mendeploy containerized application ke dalam Kubernetes Cluster. Deployment menginstruksikan Kubernetes cara membuat atau memperbarui sebuah aplikasi. Setelah Deployment dibuat, Kubernetes master mendaftarkan aplikasi yang sudah ditentukan dalam konfigurasi Deployment ke Node-Node di dalam Cluster.  

Setelah aplikasi diluncurkan, Kubernetes Deployment Controller memonitor _instance_ aplikasi tersebut. Apabila ada Node yang sedang menjalankan _instance_ aplikasi tersebut mati (_down_) atau dihapus, Deployment controller mengganti _instance_ tersebut dengan membuat _instance_ baru di Node lain dalam Cluster yang sama. Proses tersebut memberikan mekanisme self-healing apabila terjadi kesalahan tertentu.  

Deployment dapat digunakan untuk mengupdate _state_ dari suatu Pod, melakukan update aplikasi dalam Pod, melakukan rollback ke versi aplikasi sebelumnya, melakukan scaling.  

## ReplicaSets

Merupakan object controller di Kubernetes yang berguna untuk mengelola banyaknya replika dari sebuah Pod dalam Deployment. Deployment menyediakan opsi untuk mengatur ReplicaSets secara otomatis dengan opsi `replicas`. Dalam konfigurasi dibawah Deployment memerintah ReplicaSets untuk membuat 3 replica untuk Pods dengan label `app: nginx`.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
```

# Konsep Kerja Kubernetes
User membuat Deployment dengan konfigurasi dan image yang diinginkan
Deployment membuat Pods berisi layanan dan containerized application sesuai konfigurasi Deployment sebelumnya,
Deployment Controller (DC) melakukan provisioning terhadap Deployment yang sudah dibuat, apabila terjadi error, DC dapat melakukan mekanisme self-healing sesuai dengan banyaknya replica yang dibuat.
![Self Healing](/assets/images/Kubernetes-Intro-1/replicaset1.jpeg)
![Self Healing](/assets/images/Kubernetes-Intro-1/replicaset2.jpeg)
