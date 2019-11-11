---
title:  "How to add SSL between Alfresco Content Services and Alfresco Search Services"
categories: 
    - blog
    - alfresco
    - howto
tags: 
    - alfresco
    - acs
    - search
    - acs
    - ass
    - asms
---

The following assume that Alfresco Content Service (ACS) 6.1 is setup and working and **Alfresco Search Management Service (ASMS) 1.3 is not setup**.

Note: Alfresco Search Services has been rebranded to Alfresco Search Management Service (ASMS)

# Prerequisite

Download the following components:
1. [alfresco-ssl-generator from github](https://github.com/Alfresco/alfresco-ssl-generator)
2. ASMS 1.3 zip

# Generate Certificates

Clone the [alfresco-ssl-generator](https://github.com/Alfresco/alfresco-ssl-generator) repository to a local folder:

```shell
[vagrant@acs1 ~]$ git clone https://github.com/Alfresco/alfresco-ssl-generator.git
```

Navigate to the cloned directory alfresco-ssl-generator, make run.sh executeable and then execute this:

```shell
[vagrant@acs1 ~]$ cd alfresco-ssl-generator/ssl-tool
[vagrant@acs1 ssl-tool]$ sudo chmod +x run.sh
[vagrant@acs1 ssl-tool]$ ./run.sh
```

This will generated a set of keys with the default passwords that are hard coded into [run.sh](https://github.com/Alfresco/alfresco-ssl-generator/blob/master/ssl-tool/run.sh#L70). These are the default passwords at the time of writing:

```
# Default password for every keystore and private key	
KEYSTORE_PASS=keystore
# Default password for every truststore
TRUSTSTORE_PASS=truststore
```

There are options available to change these from the command line. These are documented on the alfresco-ssl-generator's github repository.

The directory structure and files are well documented on [Alfresco's documentation pages](https://docs.alfresco.com/search-enterprise/concepts/keystore-structure.html).

The run.sh script will generate quite a few directories and files. The **only** files that are of interest to us are:

```
/keystores
├── alfresco
│   ├── ssl-keystore-passwords.properties
│   ├── ssl-truststore-passwords.properties
│   ├── ssl.keystore
│   └── ssl.truststore
├── client
│   └── browser.p12
└── solr
│   ├── ssl-keystore-passwords.properties
│   ├── ssl-truststore-passwords.properties
│   ├── ssl.repo.client.keystore
│   └── ssl.repo.client.truststore
```



**CAUTION! As the repository is already setup, we do not want to copy over all the files from alfresco-ssl-generator/keystores/alfresco. This will causes errors when ACS is started as the keystore and keystore-passwords.properties files must match what is stored in the repository**

# Depoly and Configure ASMS 1.3

The easiest way to deploy ASMS 1.3 is to download the zip from Alfresco and unzip this to a folder of your choice.

In my case I have extracted to the same directory that Alfresco is installed in. Here is my folder structure for ACS:

```
/alf
└── acs-610
    ├── activemq
    ├── alf_data
    ├── alfresco-pdf-renderer
    ├── alfresco-search-services
    ├── amps
    ├── amps_share
    ├── bin
    ├── images
    ├── java
    ├── licenses
    ├── modules
    ├── scripts
    ├── tomcat
    └── web-server
```

As AMSM has **not** already been deployed, we need to configure the solr template that is used to create the alfresco and archive cores. We can do this by completing the following steps:

## Setting up environment variables
1. Using a text editor open the ```solr.in.sh``` file and add the following environment variables, in the above directory structure this found in ```/alf/acs-610/alfresco-search-services/```

### Solr port

```SOLR_ALFRESCO_PORT=8983```

### SSL related configurations

```
SOLR_SSL_KEY_STORE=SOLR_HOME/keystore/ssl.repo.client.keystore
SOLR_SSL_KEY_STORE_PASSWORD=keystore
SOLR_SSL_TRUST_STORE=SOLR_HOME/keystore/ssl.repo.client.truststore
SOLR_SSL_TRUST_STORE_PASSWORD=truststore
SOLR_SSL_NEED_CLIENT_AUTH=true 
SOLR_SSL_WANT_CLIENT_AUTH=false
```

In this configuration ```SOLR_HOME``` would be replaced with ```/alf/acs-610/alfresco-search-services/solrhome```

Also, the values for ```SOLR_SSL_KEY_STORE_PASSWORD``` and ```SOLR_SSL_TRUST_STORE_PASSWORD``` need to match what you set when generating keys using the alfresco-ssl-generator tool.

## Deploy SSL keys

Copy the SSL keys generated for **solr** into two locations, in this setup the two locations are:

1. ```/alf/acs-610/alfresco-search-services/solrhome/keystore`` (keystore directory needs to be created)
2. ```/alf/acs-610/alfresco-search-services/solrhome/templates/rerank/conf```


There are four files in total:
1. ssl-keystore-passwords.properties
2. ssl.repo.client.keystore
3. ssl.repo.client.truststore
4. ssl-truststore-passwords.properties

In this configuration this is done as follows:

```shell
[vagrant@acs1 alfresco-search-services]$ mkdir /alf/acs-610/alfresco-search-services/solrhome/keystore
[vagrant@acs1 alfresco-search-services]$ cp \
> ~/alfresco-ssl-generator/ssl-tool/keystores/solr/* \
> /alf/acs-610/alfresco-search-services/solrhome/keystore/
[vagrant@acs1 alfresco-search-services]$ cp \
> ~/alfresco-ssl-generator/ssl-tool/keystores/solr/* \
> /alf/acs-610/alfresco-search-services/solrhome/templates/rerank/conf
```

## Create Solr Cores

The solr cores, alfresco and archive, are setup when solr is first started. Before setting up these cores, we need to check the following:

```alfresco.sercureComms=https``` should be set in ```/alf/acs-610/alfresco-search-services/solrhome/templates/rerank/conf/solrcore.properties```

The following command will generate the two solr cores **and only needs to be run the first time ASMS is started up**:


```
[vagrant@acs1 alfresco-search-services]$ pwd
/alf/acs-610/alfresco-search-services
[vagrant@acs1 alfresco-search-services]$ ./solr/bin/solr start -a "-Djavax.net.ssl.keyStoreType=JCEKS -Djavax.net.ssl.trustStoreType=JCEKS -Dsolr.ssl.checkPeerName=false -Dcreate.alfresco.defaults=alfresco,archive"
Waiting up to 180 seconds to see Solr running on port 8983 [\]
Started Solr server on port 8983 (pid=5703). Happy searching!
```

At this point ASMS is successufully configured. The simple test is to browse to the solr admin console URL via http and https and check accessability. Replace ```localhost``` with your server name in the following URLs:

```
http://localhost:8983/solr
https://localhost:8983/solr
```

You should find that accessing via http returns an invalid response, and accessing via https requests a client certificate to be provided. This client certificate was generated by the alfresco-ssl-generator tool (browser.p12), the documentation on how to configure a client browser can be found on [Alfresco's Documentation Page](https://docs.alfresco.com/search-enterprise/tasks/ssl-protect-solrwebapp.html), just make sure to use the ```browser.p12`` file that was generated.

## Finally

We can leave ASMS running while we configure ACS to accept connections on port 8443. Just remember that when stop and starting ASMS, use the solr scripts.

Stopping: 

```./solr/bin/solr stop```

Starting: 

```./solr/bin/solr start```

# Configuring Alfresco Content Services

As we already have the SSL keys generated from the above steps, configuring ACS only requires the following steps.

## Deploy SSL Keys

A word of caution, when using the alfresco-ssl-generator tool, keystore files are generated as if this was a brand new installation. As it's likely that ACS is already setup, we only require the following files:

```
ssl.keystore
ssl-keystore-passwords.properties
ssl.truststore
ssl-truststore-passwords.properties
```

**Before making changes to the ACS keystore files, make sure you take a backup!** I this case, I made a copy of the keystore folder as follows:

```shell
[vagrant@acs1 alfresco-search-services] cp -R /alf/acs-610/alf_data/keystore /alf/acs-610/alf_data/keystore_backup
```

We can then copy the four newly generated keys into the ACS keystore:

```shell
[vagrant@acs1 alfresco-search-services] cp  ~/alfresco-ssl-generator/ssl-tool/keystores/alfresco/ssl.* /alf/acs-610/alf_data/keystore/
[vagrant@acs1 alfresco-search-services] cp ~/alfresco-ssl-generator/ssl-tool/keystores/alfresco/ssl-* /alf/acs-610/alf_data/keystore
```

## Configure Tomcat for SSL

Tomcat must be configured to communicate with solr via mutual TLS. To do this locate the ```TOMCAT_HOME>/conf/server.xml``` file and make sure the following is configured:

```xml
<Connector port="8443" protocol="org.apache.coyote.http11.Http11Protocol"
    SSLEnabled="true" maxThreads="150" scheme="https"
    keystoreFile="/alf/acs-610/alf_data/keystore/ssl.keystore"
    keystorePass="keystore" keystoreType="JCEKS"
    secure="true" connectionTimeout="240000"
    truststoreFile="/alf/acs-610/alf_data/keystore/ssl.truststore"
    truststorePass="truststore" truststoreType="JCEKS"
    clientAuth="want" sslProtocol="TLS" />
```

In this environment, my server.xml file is located in ```/alf/acs-610/tomcat/conf/server.xml```

The important elements to note are:

#### Keystore and Truststore file locations:
- keystoreFile="/alf/acs-610/alf_data/keystore/ssl.keystore"
- truststoreFile="/alf/acs-610/alf_data/keystore/ssl.truststore"

These files are the ones we copied above

#### Keystore and Truststore passwords
- keystorePass="keystore"
- truststorePass="truststore"

These passwords were set when we used the alfresco-ssl-generator tool.

## Configure Alfresco Content Services for Secure Comms to Solr

This can be done one of two ways:

1. Via the repository admin console, in the Search Services page.
2. By adding the following configuration to the alfresco-global.properties page :

```shell
#
# Set this property unless you have explicitly chosen to expose some repository APIs without authentication
solr.secureComms=https

# ssl encryption
encryption.ssl.keystore.location=${dir.keystore}/ssl.keystore
encryption.ssl.keystore.type=JCEKS
encryption.ssl.keystore.keyMetaData.location=${dir.keystore}/ssl-keystore-passwords.properties
encryption.ssl.truststore.location=${dir.keystore}/ssl.truststore
encryption.ssl.truststore.type=JCEKS
encryption.ssl.truststore.keyMetaData.location=${dir.keystore}/ssl-truststore-passwords.properties

# secret key keystore configuration
encryption.keystore.location=${dir.keystore}/keystore
encryption.keystore.keyMetaData.location=${dir.keystore}/keystore-passwords.properties
encryption.keystore.type=JCEKS

solr.host=localhost
solr.port=8983
solr.port.ssl=8983
```

We should note the following variable are also set in alfresco-global.properties:
```shell
dir.root=/alf/acs-610/alf_data
dir.keystore=${dir.root}/keystore
```

# Testing

We can now restart ACS and ASMS.

In ASMS, we should monitor the solr.log for errors, specifically around tracking.

In ACS, we should perform test searches and confirm that no exceptions are logged.

# Useful Links

Angel Borroy's Blog: https://angelborroy.wordpress.com/2016/06/15/configuring-alfresco-ssl-certificates/
Deploy Alfresco Search Service / Alfresco Search Management Service: https://docs.alfresco.com/search-enterprise/tasks/solr-install.html
Deploy ACS on Tomcat: https://docs.alfresco.com/6.1/tasks/configfiles-change-path.html