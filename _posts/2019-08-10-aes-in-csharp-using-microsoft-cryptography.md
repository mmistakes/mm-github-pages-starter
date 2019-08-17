---
title:  "AES In C# using Microsoft Cryptography Library"
date:   2019-08-08
categories:
  - cryptography
tags:
  - C#
  - aes
  - crytpography
---
Sample class library implementing AES using Microsoft's Cryptography Library

## Introduction
The **Advanced Encryption Standard (AES)**, also known by its original name **Rijndael** is a specification for the encryption of electronic data. AES is a subset of the Rijndael block cipher developed by two Belgian cryptographers, Vincent Rijmen and Joan Daemen.

AES is a symmetric key algorithm, meaning the same key is used for both encryption and decryption of data.

## AES In .NET Core
[Aes](https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.aes?view=netcore-2.2) represents the abstract base class from which all implementations of AES mush inherit. .NET also provides following implementations of AES at the time of writing.
* AesCng
* AesCryptoServiceProvider
* AesManaged

Aes abstract base class also provides static methods to create an instance of an implementation
* Create() - creates an instance AesCryptoServiceProvider by default

## Implementation
Lets start using AES in our code. We would need to include `System.Security.Cryptography` namespace.

```csharp
using System.Security.Cryptography;
```

### Encryption
Encrypt method accepts a string and key, encrypts string with key and random IV and returns a base64 encoded string packing IV and encrypted string.
We will start by creating an instance of Aes and setting key, following will create the default implementation.
```csharp
var aes = Aes.Create();
aes.Key = key;
```
Create Encryptor, using provided key and random IV (initialisation vector) this would create different cipher text using the same key
```csharp
var cryptoTransform = aes.CreateEncryptor(aes.Key, aes.IV);
```
Call internal method to encrypt string and create cipher text.
```csharp
var cipherText = Encrypt(plainText, cryptoTransform);
```
We then pack the data in a byte array along with IV and convert to base64 string. IV would be required to decrypt data along with key if not packed with encrypted data.

Complete code for the method is below

```csharp
public string Encrypt(string plainText, byte[] key)
{
    using (var aes = Aes.Create())
    {
        aes.Key = key;

        var cryptoTransform = aes.CreateEncryptor(aes.Key, aes.IV);

        var cipherText = Encrypt(plainText, cryptoTransform);
        
        var data = new byte[cipherText.Length + aes.IV.Length + 1];
        data[0] = (byte) aes.IV.Length;
        Array.Copy(aes.IV, 0, data, 1, aes.IV.Length);
        Array.Copy(cipherText, 0, data, aes.IV.Length + 1, cipherText.Length);
        return Convert.ToBase64String(data);
    }
}
```

Private method accepts data and encryptor, creates a memory stream
```csharp
var memoryStream = new MemoryStream();
```
Initialises a crypto stream with memory stream, encryptor and write mode
```csharp
var cryptoStream = new CryptoStream(memoryStream, cryptoTransform, CryptoStreamMode.Write);
```
Creates a writer using crypto stream and call Write method to perform the encryption
```csharp
var writer = new StreamWriter(cryptoStream);
writer.Write(data);
```

Complete code for the method is below
```csharp
private byte[] Encrypt(string data, ICryptoTransform cryptoTransform)
{
    if (data == null || data.Length <= 0)
        throw new ArgumentException(nameof(data));

    using (MemoryStream memoryStream = new MemoryStream())
    {
        using (var cryptoStream = new CryptoStream(memoryStream, cryptoTransform, CryptoStreamMode.Write))
        {
            using (var writer = new StreamWriter(cryptoStream))
            {
                writer.Write(data);
            }
        }

        return memoryStream.ToArray();
    }
}
```

### Decryption
Decrypt method works in conjunction with Encrypt method above, it accepts base64 encoded string and key. It unpacks base64 encoded string to get iv and encrypted data and performs decryption and returns plain text.
We will start by unpacking cipher text to get IV used to encrypt data and encrypted data and follow that by creating an instance of Aes and setting key and IV
```csharp
var aes = Aes.Create();
aes.Key = key;
aes.IV = iv;
```
Create Decryptor,
```csharp
var cryptoTransform = aes.CreateDecryptor(aes.Key, aes.IV);
```
Call internal method to decrypt data and return decrypted string
```csharp
return Decrypt(encrypted, cryptoTransform);
```

Complete code for the method is below

```csharp
public string Decrypt(string cipherText, byte[] key)
{
    var data = Convert.FromBase64String(cipherText);
    byte ivSize = data[0];
    var iv = new byte[ivSize];
    Array.Copy(data, 1, iv, 0, ivSize);
    var encrypted = new byte[data.Length - ivSize - 1];
    Array.Copy(data, ivSize + 1, encrypted, 0, encrypted.Length);

    using (var aes = Aes.Create())
    {
        aes.Key = key;
        aes.IV = iv;

        var cryptoTransform = aes.CreateDecryptor(aes.Key, aes.IV);
        return Decrypt(encrypted, cryptoTransform);
    }
}
```

Private method accepts data and decryptor, creates a memory stream using encrypted data
```csharp
var memoryStream = new MemoryStream(data)
```
Initialises a crypto stream with memory stream, decryptor and read mode
```csharp
var cryptoStream = new CryptoStream(memoryStream, cryptoTransform, CryptoStreamMode.Read)
```
Creates a reader using crypto stream and call Read method to perform the decryption
```csharp
var reader = new StreamReader(cryptoStream)
var decrypted = reader.ReadToEnd();
```

Complete code for the method is below
```csharp
private string Decrypt(byte[] data, ICryptoTransform cryptoTransform)
{
    if (data == null || data.Length <= 0)
        throw new ArgumentException(nameof(data));

    using (var memoryStream = new MemoryStream(data))
    {
        using (var cryptoStream = new CryptoStream(memoryStream, cryptoTransform, CryptoStreamMode.Read))
        {
            using (var reader = new StreamReader(cryptoStream))
            {
                return reader.ReadToEnd();
            }
        }
    }
}
```

Complete code for the wrapper class that implements encryption and decryption using Aes can be found at [AesCrypto.cs](https://github.com/kashifsoofi/crypto-sandbox/blob/master/dotnet/src/Sandbox.Crypto/AesCrypto.cs). Unit tests for the wrapper class can be found at [AesCryptoTests.cs](https://github.com/kashifsoofi/crypto-sandbox/blob/master/dotnet/test/Sandbox.Crypto.Tests/AesCryptoTests.cs). Complete project as class library along with tests is at [CryptoSandbox](https://github.com/kashifsoofi/crypto-sandbox/tree/master/dotnet).

## References
[https://en.wikipedia.org/wiki/Advanced_Encryption_Standard](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)
[https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.aes?view=netcore-2.2](https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.aes?view=netcore-2.2)