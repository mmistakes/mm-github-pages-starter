---
title:  "AES In Java using Crypto API"
date:   2019-09-04
categories:
  - cryptography
tags:
  - Java
  - aes
  - crytpography
---
Sample class library implementing AES using Java Crypto API

## Introduction
The **Advanced Encryption Standard (AES)**, also known by its original name **Rijndael** is a specification for the encryption of electronic data. AES is a subset of the Rijndael block cipher developed by two Belgian cryptographers, Vincent Rijmen and Joan Daemen.

AES is a symmetric key algorithm, meaning the same key is used for both encryption and decryption of data.

## Java Cryptography Architecture
[Java Cryptography Architecture](https://en.wikipedia.org/wiki/Java_Cryptography_Architecture) is a framework for working with cryptography using Java. It contains a set of APIs for various purposes such as encryption, key generation and management etc. In this article we will look at AES encryption capabilities.

## Implementation
Lets start using AES in our code. We would need to import following crypto packages.
```java
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
```

We would also need following security packages.
```java
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.SecureRandom;
import java.security.spec.AlgorithmParameterSpec;
import java.security.spec.KeySpec;
```

And finally following utitlity package imports.
```java
import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;
```

### Encryption
encrypt method accepts a string and key, encrypts string with key and random IV and returns a base64 encoded string packing IV and encrypted string. Our wrapper is using following 2 variations of the transforms.
* AES/GCM/NoPadding (default)
* AES/CBC/PKCS5Padding - compatible with Micosoft's System.Security.AES and BouncyCastle.Net's AES/CBC/PKCS7

We will start by creating a `SecretKeySpec` object using key bytes passed to the method.
```java
SecretKey secretKey = new SecretKeySpec(key, ALGORITHM);
```
Next we will create an instane of SecureRandom and generate random IV.
```java
SecureRandom random = new SecureRandom();
byte[] iv = random.generateSeed(AesIvSize);
```
We will then create an instance of cipher using `Cipher.getInstance` helper method by passing the transformation to use. We call `getTransformation` helper method to get current transformation to use as set in the constructor. Transformation would be either `AES/GCM/NoPadding` or `AES/CBC/PKCS5Padding`. We then initialise `cipher` object with `ENCRYPT_MODE`, `secretKey` and transformation specific parameters, created using `createParameterSpec` helper method. 
```java
Cipher cipher = Cipher.getInstance(getTransformation());
cipher.init(Cipher.ENCRYPT_MODE, secretKey, createParameterSpec(iv, GcmTagSize * 8));
```
We then have to convert plain text to bytes and call `doFinal` method on `cipher` object to encrypt data.
```java
byte[] plainTextBytes = plainText.getBytes("UTF8");
byte[] encryptedBytes = cipher.doFinal(plainTextBytes);
```
We finally pack the data in a byte array along with IV, GCM tag size (depending on CipherMode) and convert to base64 string. IV/gcm tag size would be required to decrypt data along with key if not packed with encrypted data.

Complete code for the method is below

```java
public String encrypt(String plainText, byte[] key)
  throws InvalidKeyException, InvalidAlgorithmParameterException, Exception {
    SecretKey secretKey = new SecretKeySpec(key, ALGORITHM);

    SecureRandom random = new SecureRandom();
    byte[] iv = random.generateSeed(AesIvSize);

    Cipher cipher = Cipher.getInstance(getTransformation());
    cipher.init(Cipher.ENCRYPT_MODE, secretKey, createParameterSpec(iv, GcmTagSize * 8));

    byte[] plainTextBytes = plainText.getBytes("UTF8");
    byte[] encryptedBytes = cipher.doFinal(plainTextBytes);
    return packCipherData(encryptedBytes, iv);
}
```

### Decryption
decrypt method works in conjunction with encrypt method above, it accepts base64 encoded cipher text string and key. It unpacks base64 encoded string to get iv, gcm tag size if CipherMode is GCM and encrypted data bytes and performs decryption and returns plain text.

We will start by creating a `SecretKeySpec` object using key bytes passed to the method.
```java
SecretKey secretKey = new SecretKeySpec(key, ALGORITHM);
```
We will then unpack cipher text to get IV used to encrypt data, gcm tag size and encrypted data bytes.
```java
List<Object> cipherData = unpackCipherData(cipherText);
byte[] encryptedBytes = (byte[])cipherData.get(0);
byte[] iv = (byte[])cipherData.get(1);
byte gcmTagSize = (byte)cipherData.get(2);
```
We will then create an instance of cipher using `Cipher.getInstance` helper method by passing the transformation to use. We call `getTransformation` helper method to get current transformation to use as set in the constructor. Transformation would be either `AES/GCM/NoPadding` or `AES/CBC/PKCS5Padding`. We then initialise `cipher` object with `DECRYPT_MODE`, `secretKey` and transformation specific parameters, created using `createParameterSpec` helper method. 
```java
Cipher cipher = Cipher.getInstance(getTransformation());
cipher.init(Cipher.DECRYPT_MODE, secretKey, createParameterSpec(iv, gcmTagSize * 8));
```
We will follow that by a call `doFinal` method on `cipher` object to decrypt data.
```java
byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
```
And finally we convert decrypted bytes to UTF8 string and return to caller.
```java
return new String(decryptedBytes, "UTF8");
```

Complete code for the method is below

```java
public String decrypt(String cipherText, byte[] key)
  throws InvalidKeyException, InvalidAlgorithmParameterException, Exception {
    SecretKey secretKey = new SecretKeySpec(key, ALGORITHM);

    List<Object> cipherData = unpackCipherData(cipherText);
    byte[] encryptedBytes = (byte[])cipherData.get(0);
    byte[] iv = (byte[])cipherData.get(1);
    byte gcmTagSize = (byte)cipherData.get(2);

    Cipher cipher = Cipher.getInstance(getTransformation());
    cipher.init(Cipher.DECRYPT_MODE, secretKey, createParameterSpec(iv, gcmTagSize * 8));

    byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
    return new String(decryptedBytes, "UTF8");
}
```

Complete code for the wrapper class that implements encryption and decryption using Java Cryptography APIs' Aes can be found at [AesCrypto.java](https://github.com/kashifsoofi/crypto-sandbox/blob/master/java/aescrypto/AesBcCrypto.java). Unit tests for the wrapper class can be found at [AesCryptoTests.java](https://github.com/kashifsoofi/crypto-sandbox/blob/master/java/aescrypto/AesCryptoTests.java). Complete repository with other samples and languages can be found at [CryptoSandbox](https://github.com/kashifsoofi/crypto-sandbox).

## References
[https://en.wikipedia.org/wiki/Advanced_Encryption_Standard](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)
[https://en.wikipedia.org/wiki/Java_Cryptography_Architecture](https://en.wikipedia.org/wiki/Java_Cryptography_Architecture)
[https://github.com/junit-team/junit4/wiki/Getting-started](https://github.com/junit-team/junit4/wiki/Getting-started)
And many more
