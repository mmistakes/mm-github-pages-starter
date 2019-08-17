---
title:  "RSA Signing In C# using Microsoft Cryptography Library"
date:   2019-08-08
categories:
  - cryptography
tags:
  - C#
  - rsa
  - crytpography
---
Sample class library implementing RSA signing using Microsoft's Cryptography Library

## Introduction
**RSA (Rivest–Shamir–Adleman)** is a public-key cryptostystems. In such a cryptosystem, a pair of keys is used often called private and public key pair.

Public key cryptosystems are used for 2 major use cases
# Encryption
# Verification

Focus of this article is verification. With a public key cryptosystem, private key is always kept secure by the owner and public key is publically accessible. Process of verification involves signing of data with a private key that can be verified using associated public key. Signing is always done with a private key that is only accessible by owner. Verification is done using a public key accessible by any member of the public. Anybody can use it (public key) to verify a data signature, if successful meaning it is genuinely coming from the owner of the private key.

## RSA In .NET Core
[RSA](https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.rsa?view=netcore-2.2) represents the abstract base class from which all implementations of RSA mush inherit. .NET provides following implementations of RSA at the time of writing.
* RSACng
* RSACryptoServiceProvider - used on windows
* RSAOpenSsl - used on linux/osx if openssl is installed

RSA abstract base class also provides static methods to create an instance of an implementation
* Create() - creates an instance based on platform

## Implementation
Lets start using RSA in our code for signing/verifying data. We would need to include `System.Security.Cryptography` namespace.

```csharp
using System.Security.Cryptography;
```

### Key Generation
GenerateKeyPair method creates a new instance of RSA, sets desired key size and export key pair as json strings, there is `ToXmlString` method that can be used if you are not using .NET Core.

### Sign Data
SignData method accepts a string and private key serialized as json, signs data with key using a hash and padding and finally returns a base64 encoded data signature.
We will start by creating an instance of RSA and importing key.
```csharp
var rsa = RSA.Create();
rsa.ImportParameters(rsaParameters);
```
Call `SignData` method on `rsa` instance to encrypt data.
```csharp
var signature = rsa.SignData(dataToSign, HashAlgorithmName.SHA512, RSASignaturePadding.Pkcs1);
```
We then convert signature to base64 string and return to caller.

Complete code for the method is below
```csharp
public string SignData(string data, string privateKeyJson)
{
    using (var rsa = RSA.Create())
    {
        var rsaParameters = JsonConvert.DeserializeObject<RSAParameters>(privateKeyJson);
        rsa.ImportParameters(rsaParameters);

        var dataToSign = Encoding.UTF8.GetBytes(data);
        var signature = rsa.SignData(dataToSign, HashAlgorithmName.SHA512, RSASignaturePadding.Pkcs1);
        return Convert.ToBase64String(signature);
    }
}
```

### Verify Signature
VerifySignature method works in conjunction with SignData method above, it accepts data, base64 encoded signature and public key serialized as json. It imports key, performs verification and returns a boolean result.

We will start by creating an instance of RSA and importing key.
```csharp
var rsa = RSA.Create();
rsa.ImportParameters(rsaParameters);
```
Call `VerifyData` method on `rsa` instance to decrypt data.
```csharp
rsa.VerifyData(dataToVerify, signatureData, HashAlgorithmName.SHA512, RSASignaturePadding.Pkcs1);
```
And return the result of VerifyData back to caller.

Complete code for the method is below
```csharp
public bool VerifySignature(string data, string signature, string publicKeyJson)
{
    using (var rsa = RSA.Create())
    {
        var rsaParameters = JsonConvert.DeserializeObject<RSAParameters>(publicKeyJson);
        rsa.ImportParameters(rsaParameters);

        var dataToVerify = Encoding.UTF8.GetBytes(data);
        var signatureData = Convert.FromBase64String(signature);
        return rsa.VerifyData(dataToVerify, signatureData, HashAlgorithmName.SHA512, RSASignaturePadding.Pkcs1);
    }
}
```

Complete code for the wrapper class that implements encryption and decryption using RSA can be found at [RsaCrypto.cs](https://github.com/kashifsoofi/crypto-sandbox/blob/master/dotnet/src/Sandbox.Crypto/RsaCrypto.cs). Unit tests for the wrapper class can be found at [RsaCryptoTests.cs](https://github.com/kashifsoofi/crypto-sandbox/blob/master/dotnet/test/Sandbox.Crypto.Tests/RsaCryptoTests.cs). Complete project as class library along with tests is at [CryptoSandbox](https://github.com/kashifsoofi/crypto-sandbox/tree/master/dotnet).

## References
[https://en.wikipedia.org/wiki/RSA_(cryptosystem)](https://en.wikipedia.org/wiki/RSA_(cryptosystem))
[https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.rsa?view=netcore-2.2](https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.rsa?view=netcore-2.2)