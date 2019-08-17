---
title:  "RSA Encryption In C# using Microsoft Cryptography Library"
date:   2019-08-08
categories:
  - cryptography
tags:
  - C#
  - rsa
  - crytpography
---
Sample class library implementing RSA encryption using Microsoft's Cryptography Library

## Introduction
**RSA (Rivest–Shamir–Adleman)** is a public-key cryptostystems. In such a cryptosystem, a pair of keys is used often called private and public key pair.

Public key cryptosystems are used for 2 major use cases
# Encryption
# Verification

Focus of this article is encryption. With a public key cryptosystem, private key is always kept secure by the owner and public key is publically accessible. Encryption is always done with a public key, this ensures that only the owner of private key can access the data unencrypted and will remain private between the encrytor and owner of private key.

## RSA In .NET Core
[RSA](https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.rsa?view=netcore-2.2) represents the abstract base class from which all implementations of RSA mush inherit. .NET provides following implementations of RSA at the time of writing.
* RSACng
* RSACryptoServiceProvider - used on windows
* RSAOpenSsl - used on linux/osx if openssl is installed

RSA abstract base class also provides static methods to create an instance of an implementation
* Create() - creates an instance based on platform

## Implementation
Lets start using RSA in our code. We would need to include `System.Security.Cryptography` namespace.

```csharp
using System.Security.Cryptography;
```

### Key Generation
GenerateKeyPair method creates a new instance of RSA, sets desired key size and export key pair as json strings, there is `ToXmlString` method that can be used if you are using not using .NET Core.

### Encryption
Encrypt method accepts a string and public key serialized as json, encrypts string with key using a padding and returns a base64 encoded encrypted string.
We will start by creating an instance of RSA and importing key.
```csharp
var rsa = RSA.Create();
rsa.ImportParameters(rsaParameters);
```
Call `Encrypt` method on `rsa` instance to encrypt data.
```csharp
var encryptedData = rsa.Encrypt(dataToEncrypt, RSAEncryptionPadding.Pkcs1);
```
We then convert encrypted data to base64 string and return to caller.

Complete code for the method is below
```csharp
public string Encrypt(string plainText, string publicKeyJson)
{
    using (var rsa = RSA.Create())
    {
        var rsaParameters = JsonConvert.DeserializeObject<RSAParameters>(publicKeyJson);
        rsa.ImportParameters(rsaParameters);

        var dataToEncrypt = Encoding.UTF8.GetBytes(plainText);
        var encryptedData = rsa.Encrypt(dataToEncrypt, RSAEncryptionPadding.Pkcs1);
        return Convert.ToBase64String(encryptedData);
    }
}
```

### Decryption
Decrypt method works in conjunction with Encrypt method above, it accepts base64 encoded string and private key serialized as json. It imports key, performs decryption and returns plain text.

We will start by creating an instance of RSA and importing key.
```csharp
var rsa = RSA.Create();
rsa.ImportParameters(rsaParameters);
```
Call `Decrypt` method on `rsa` instance to decrypt data.
```csharp
var decryptedData = rsa.Decrypt(dataToDecrypt, RSAEncryptionPadding.Pkcs1);
```
We then convert decrypted data to string and return to caller.

Complete code for the method is below
```csharp
public string Decrypt(string encryptedData, string privateKeyJson)
{
    using (var rsa = RSA.Create())
    {
        var rsaParameters = JsonConvert.DeserializeObject<RSAParameters>(privateKeyJson);
        rsa.ImportParameters(rsaParameters);

        var dataToDecrypt = Convert.FromBase64String(encryptedData);
        var decryptedData = rsa.Decrypt(dataToDecrypt, RSAEncryptionPadding.Pkcs1);
        return Encoding.UTF8.GetString(decryptedData);
    }
}
```

Complete code for the wrapper class that implements encryption and decryption using RSA can be found at [RsaCrypto.cs](https://github.com/kashifsoofi/crypto-sandbox/blob/master/dotnet/src/Sandbox.Crypto/RsaCrypto.cs). Unit tests for the wrapper class can be found at [RsaCryptoTests.cs](https://github.com/kashifsoofi/crypto-sandbox/blob/master/dotnet/test/Sandbox.Crypto.Tests/RsaCryptoTests.cs). Complete project as class library along with tests is at [CryptoSandbox](https://github.com/kashifsoofi/crypto-sandbox/tree/master/dotnet).

## References
[https://en.wikipedia.org/wiki/RSA_(cryptosystem)](https://en.wikipedia.org/wiki/RSA_(cryptosystem))
[https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.rsa?view=netcore-2.2](https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.rsa?view=netcore-2.2)