---
title:  "AES In C# using BouncyCastle.Net"
date:   2019-08-08
categories:
  - cryptography
tags:
  - C#
  - aes
  - crytpography
  - bouncy castle
---
Sample class library implementing AES using Bouncy Castle (1.8.5)

## Introduction
The **Advanced Encryption Standard (AES)**, also known by its original name **Rijndael** is a specification for the encryption of electronic data. AES is a subset of the Rijndael block cipher developed by two Belgian cryptographers, Vincent Rijmen and Joan Daemen.

AES is a symmetric key algorithm, meaning the same key is used for both encryption and decryption of data.

## Bouncy Castle
[Bouncy Castle Crypto APIs](http://www.bouncycastle.org/index.html) are lightweight crypto APIs for Java and C#. In this article we will look at using C# implementation of AES.

## Implementation
Lets start using AES in our code. We would need to include following namespaces.
```csharp
using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.Crypto.Parameters;
using Org.BouncyCastle.Security
```

### Encryption
Encrypt method accepts a string and key, encrypts string with key and random IV and returns a base64 encoded string packing IV and encrypted string. Our wrapper is using following 2 variations of the transforms.
* AES/GCM/NoPadding (default)
* AES/CBC/PKCS7 - compatible with System.Security.AES

We will start by generating random IV using `SecureRandom` provided by BouncyCastle.
```csharp
var random = new SecureRandom();
var iv = random.GenerateSeed(AesIvSize);
```
We will then call `CreateKeyParameters` helper method to create `ICipherParameters`. `CreateKeyParameters` would create appropriate key parameters to pass to initialise method of the cipher depending on current cipher mode.
```csharp
var keyParameters = CreateKeyParameters(key, iv, GcmTagSize * 8);
```
We will now create cipher using `CipherUtilities` helper of `BouncyCastle` and initialise it with encryptMode and keyParameters
```csharp
var cipher = CipherUtilities.GetCipher(_algorithm);
cipher.Init(true, keyParameters);
```
Convert plain text string to bytes and call `DoFinal` method on `cipher` object to encrypt data.
```csharp
var plainTextData = Encoding.UTF8.GetBytes(plainText);
var cipherText = cipher.DoFinal(plainTextData);
```
We finally pack the data in a byte array along with IV, GCM tag size (depending on CipherMode) and convert to base64 string. IV/gcm tag size would be required to decrypt data along with key if not packed with encrypted data.

Complete code for the method is below

```csharp
public string Encrypt(string plainText, byte[] key)
{
    var random = new SecureRandom();
    var iv = random.GenerateSeed(AesIvSize);
    var keyParameters = CreateKeyParameters(key, iv, GcmTagSize * 8);
    var cipher = CipherUtilities.GetCipher(_algorithm);
    cipher.Init(true, keyParameters);

    var plainTextData = Encoding.UTF8.GetBytes(plainText);
    var cipherText = cipher.DoFinal(plainTextData);

    return PackCipherData(cipherText, iv);
}
```

### Decryption
Decrypt method works in conjunction with Encrypt method above, it accepts base64 encoded cipher text string and key. It unpacks base64 encoded string to get iv, gcm tag size if CipherMode is GCM and encrypted data bytes and performs decryption and returns plain text.

We will start by unpacking cipher text to get IV used to encrypt data, gcm tag size and encrypted data bytes and follow that by creating key parameters using helper method `CreateKeyParameters`.
```csharp
var (encryptedBytes, iv, tagSize) = UnpackCipherData(cipherText);
var keyParameters = CreateKeyParameters(key, iv, tagSize * 8);
```
We will follow that by creating cipher using `CipherUtilities` helper of `BouncyCastle` and initialise it with decryption mode and key parameters.
```csharp
var cipher = CipherUtilities.GetCipher(_algorithm);
cipher.Init(false, keyParameters);
```
Call `DoFinal` method on `cipher` object to decrypt data.
```csharp
var decryptedData = cipher.DoFinal(encryptedBytes);
```
And finally we convert decrypted bytes to UTF8 string and return to caller.
```csharp
return Encoding.UTF8.GetString(decryptedData);
```

Complete code for the method is below

```csharp
public string Decrypt(string cipherText, byte[] key)
{
    var (encryptedBytes, iv, tagSize) = UnpackCipherData(cipherText);
    var keyParameters = CreateKeyParameters(key, iv, tagSize * 8);
    var cipher = CipherUtilities.GetCipher(_algorithm);
    cipher.Init(false, keyParameters);

    var decryptedData = cipher.DoFinal(encryptedBytes);
    return Encoding.UTF8.GetString(decryptedData);
}
```

Complete code for the wrapper class that implements encryption and decryption using BouncyCastle Aes can be found at [AesBcCrypto.cs](https://github.com/kashifsoofi/crypto-sandbox/blob/master/dotnet/src/Sandbox.Crypto/AesBcCrypto.cs). Unit tests for the wrapper class can be found at [AesBcCryptoTests.cs](https://github.com/kashifsoofi/crypto-sandbox/blob/master/dotnet/test/Sandbox.Crypto.Tests/AesBcCryptoTests.cs). Complete project as class library along with tests is at [CryptoSandbox](https://github.com/kashifsoofi/crypto-sandbox/tree/master/dotnet).

## References
[https://en.wikipedia.org/wiki/Advanced_Encryption_Standard](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)
[http://www.bouncycastle.org/csharp/](http://www.bouncycastle.org/csharp/)