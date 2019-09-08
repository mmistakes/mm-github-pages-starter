---
title:  "AES In Go using Crypto Package"
date:   2019-09-04
categories:
  - cryptography
tags:
  - Go
  - aes
  - crytpography
---
Sample wrapper package implementing AES text encrytion/decrytion using Golang Crypto Package

## Introduction
The **Advanced Encryption Standard (AES)**, also known by its original name **Rijndael** is a specification for the encryption of electronic data. AES is a subset of the Rijndael block cipher developed by two Belgian cryptographers, Vincent Rijmen and Joan Daemen.

AES is a symmetric key algorithm, meaning the same key is used for both encryption and decryption of data.

## Cryptography in Golang
Golang's [crypto package](https://golang.org/pkg/crypto/) and subdirectories/sub packages provides implementation of various cryptography algorithms. In this article we will look at AES encryption capabilities.

## Implementation
Lets start using AES in our code. We would need to import following crypto packages.
```go
import (
  "crypto/aes"
  "crypto/cipher"
  "crypto/rand"
)
```

We would also need following pakcages to complete the implementation.
```go
import (
  base64 "encoding/base64"
	"io"
	"strings"
	"bytes"
	"fmt"
)
```

### Encryption
Encrypt function accepts a string and key, encrypts string using either GCM or CBC and returns a base64 encoded string packing IV and encrypted string. Our wrapper is using following 2 variations of the transforms.
* AES/GCM/NoPadding (default)
* AES/CBC/PKCS7Padding - compatible with wrapper implementations in C# and Java (in the same repo)

We will start by creating `aes` instance using `NewCipher` function from `aes` package by passing secret key.
```go
aes, err := aes.NewCipher(key)
```
We will then check for current `CipherMode` and either call `EncryptGcm` or `EncryptCbc`.  
Complete code for the method is below
```go
func (crypto AesCrypto) Encrypt(plainText string, key []byte) (string, error) {
	// create a new aes cipher using key
	aes, err := aes.NewCipher(key)
	if err != nil {
		return "", err
	}

	if crypto.CipherMode == GCM {
		return crypto.EncryptGcm(aes, plainText)
	} else {
		return crypto.EncryptCbc(aes, plainText)
	}
}
```

#### GCM/NoPadding
`EncryptGcm` function accepts `Block` cipher and plain text, encrypts plain text using GCM block cipher and returns base64 encoded string packing nonce and encrypted data.  

We start by creating a new instace of gcm block cipher using `NewGCM` function.
```go
gcm, err := cipher.NewGCM(aes)
```
Next step would be to generate random nonce
```go
nonce := make([]byte, gcm.NonceSize())
io.ReadFull(rand.Reader, nonce)
```
Next we would convert plain text to byte array and call `Seal` function on `gcm` instance to encrypt data and get cipher text.
```go
plainTextBytes := []byte(plainText)
cipherText := gcm.Seal(nil, nonce, plainTextBytes, nil)
```
We finally pack the data in a byte array along with nonce and GCM tag size, convert to base64 string and return to caller.  
Complete code for the method is below
```go
func (crypto AesCrypto) EncryptGcm(aes cipher.Block, plainText string) (string, error) {
	gcm, err := cipher.NewGCM(aes)
	if err != nil {
		return "", err
	}

	nonce := make([]byte, gcm.NonceSize())
	if _, err = io.ReadFull(rand.Reader, nonce); err != nil {
		return "", err
	}

	plainTextBytes := []byte(plainText)
	cipherText := gcm.Seal(nil, nonce, plainTextBytes, nil)

	return crypto.PackCipherData(cipherText, nonce, gcm.Overhead()), nil
}
```

#### CBC/Pkcs7
`EncryptCbc` function accepts `Block` cipher and plain text, encrypts plain text using CBC block cipher and returns base64 encoded string packing nonce and encrypted data.  

We start by generating random IV (initialization vector)
```go
iv := make([]byte, AesIvSize)
io.ReadFull(rand.Reader, iv)
```
Next we would create `encrypter` instance using `NewCBCEncrypter` function by passing in block cipher and iv.
```go
encrypter := cipher.NewCBCEncrypter(aes, iv)
```
Next we will convert plain text to bytes and encoding with Pkcs7. I couldn't find PKCS7 encoding in official packages, so I am using implmentation courtesy of [golang-examples](https://golang-examples.tumblr.com/post/98350728789/pkcs7-padding)
```go
plainTextBytes := []byte(plainText)
plainTextBytes, err := pkcs7Pad(plainTextBytes, encrypter.BlockSize())
```
Next step is to call `CryptBlocks` function of `encrypter` to encrypt data.
```go
cipherText := make([]byte, len(plainTextBytes))
encrypter.CryptBlocks(cipherText, plainTextBytes)
```
We finally pack the data in a byte array along with iv, convert to base64 string and return to caller.  
Complete code for the method is below
```go
func (crypto AesCrypto) EncryptCbc(aes cipher.Block, plainText string) (string, error) {
	iv := make([]byte, AesIvSize)
	if _, err := io.ReadFull(rand.Reader, iv); err != nil {
		return "", err
	}

	encrypter := cipher.NewCBCEncrypter(aes, iv)

	plainTextBytes := []byte(plainText)
	plainTextBytes, err := pkcs7Pad(plainTextBytes, encrypter.BlockSize())
	if err != nil {
		return "", err
	}
	
	cipherText := make([]byte, len(plainTextBytes))
	encrypter.CryptBlocks(cipherText, plainTextBytes)

	return crypto.PackCipherData(cipherText, iv, 0), nil
}
```

### Decryption
Decrypt method works in conjunction with Encrypt method above, it accepts base64 encoded cipher text string, key and provider, we use provider in gcm to create correct instance of gcm block cipher as instance with non-default values is required to decrypt data encrypted in C#/Java. It unpacks base64 encoded string to get iv, gcm tag size if CipherMode is GCM and encrypted data bytes and performs decryption and returns plain text.  

We will start by decoding base64 cipher text string to get packed cipher data.
```go
data, err := base64.StdEncoding.DecodeString(cipherText)
```
We will then call `UnpackCipherData` function to get encryptedBytes, iv/nonce and tagSize.
```go
encryptedBytes, iv, tagSize := crypto.UnpackCipherData(data)
```
Next we will create `aes` intance using `NewCipher` function from `aes` package by passing secret key.
```go
aes, err := aes.NewCipher(key)
```
We will then check for current `CipherMode` and either call `DecryptGcm` or `DecryptCbc`.  
Complete code for the method is below
```go
func (crypto AesCrypto) Decrypt(cipherText string, key []byte, provider string) (string, error) {
	data, err := base64.StdEncoding.DecodeString(cipherText)
	if err != nil {
		return "", err
	}
	
	encryptedBytes, iv, tagSize := crypto.UnpackCipherData(data)

	aes, err := aes.NewCipher(key)
	if err != nil {
		return "", err
	}

	if crypto.CipherMode == GCM {
		return DecryptGcm(aes, encryptedBytes, iv, tagSize, provider)
	} else {
		return DecryptCbc(aes, encryptedBytes, iv)
	}
}
```

#### GCM/NoPadding
`DecryptGcm` function accepts `Block` cipher, encrypted, nonce, tagSize and provider, decrypts encrypted bytes and returns plain text as string.  

We start by creating a new instace of gcm block cipher `AEAD` depending on provider.
```go
var aesgcm cipher.AEAD
var err error
if strings.EqualFold("go", provider) {
  aesgcm, err = cipher.NewGCM(aes)
} else {
  aesgcm, err = cipher.NewGCMWithNonceSize(aes, tagSize) // only used for compatibility, NewGCM recomended
}
```
We then call `Open` method on `aesgcm` instance to decrypt data.
```go
decryptedBytes, err := aesgcm.Open(nil, nonce, encrypted, nil)
```
We finally convert byte array to string and return decrypted string to caller.  
Complete code for the method is below
```go
func DecryptGcm(aes cipher.Block, encrypted []byte, nonce []byte, tagSize int, provider string) (string, error) {
	var aesgcm cipher.AEAD
	var err error
	if strings.EqualFold("go", provider) {
		aesgcm, err = cipher.NewGCM(aes)
	} else {
		aesgcm, err = cipher.NewGCMWithNonceSize(aes, tagSize) // only used for compatibility, NewGCM recomended
	}
	
	if err != nil {
		return "", err
	}

	decryptedBytes, err := aesgcm.Open(nil, nonce, encrypted, nil)
	if err != nil {
		return "", err
	}

	return string(decryptedBytes[:len(decryptedBytes)]), nil
}
```

#### CBC/Pkcs7
`DecryptCbc` function accepts `Block` cipher, encrypted bytes and iv, decrypts encrypted bytes and returns plain text as string.  

We start by creating a new instace of decryptor using function `NewCBCDecrypter`.
```go
decryptor := cipher.NewCBCDecrypter(aes, iv)
```
We then call `CryptBlocks` method on `decryptor` instance to decrypt data.
```go
decryptedBytes := make([]byte, len(encrypted))
decryptor.CryptBlocks(decryptedBytes, encrypted)
```
Next we call `pkcs7Unpad` on decrypted data to remove any padding charaters.
```go
decryptedBytes, err := pkcs7Unpad(decryptedBytes, decryptor.BlockSize())
```
We finally convert byte array to string and return decrypted string to caller.  
Complete code for the method is below
```go
func DecryptCbc(aes cipher.Block, encrypted []byte, iv []byte) (string, error) {
	decryptor := cipher.NewCBCDecrypter(aes, iv)

	decryptedBytes := make([]byte, len(encrypted))
	decryptor.CryptBlocks(decryptedBytes, encrypted)

	decryptedBytes, err := pkcs7Unpad(decryptedBytes, decryptor.BlockSize())
	if err != nil {
		return "", err
	}

	return string(decryptedBytes[:len(decryptedBytes)]), nil
}
```

## TL;DR
Complete code for the wrapper class that implements encryption and decryption using Golang Crypto package can be found at [aescrypto.go]https://github.com/kashifsoofi/crypto-sandbox/blob/master/go/aescrypto/aescrypto.go). Unit tests for the wrapper class can be found at [aescrypto_test.go](https://github.com/kashifsoofi/crypto-sandbox/blob/master/go/aescrypto/aescrypto_test.go). Complete repository with other samples and languages can be found at [CryptoSandbox](https://github.com/kashifsoofi/crypto-sandbox).

## References
In no particular order  
[https://en.wikipedia.org/wiki/Advanced_Encryption_Standard](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)
[https://golang.org/pkg/crypto/](https://golang.org/pkg/crypto/)
[https://golang-examples.tumblr.com/post/98350728789/pkcs7-padding](https://golang-examples.tumblr.com/post/98350728789/pkcs7-padding)
[https://golang.org/src/crypto/cipher/cbc.go](https://golang.org/src/crypto/cipher/cbc.go)
[https://medium.com/@matryer/5-simple-tips-and-tricks-for-writing-unit-tests-in-golang-619653f90742](https://medium.com/@matryer/5-simple-tips-and-tricks-for-writing-unit-tests-in-golang-619653f90742)
[https://godoc.org/github.com/google/uuid](https://godoc.org/github.com/google/uuid)
[https://gobyexample.com/base64-encoding](https://gobyexample.com/base64-encoding)
[https://yourbasic.org/golang/copy-explained/](https://yourbasic.org/golang/copy-explained/)
[https://tutorialedge.net/golang/go-encrypt-decrypt-aes-tutorial/](https://tutorialedge.net/golang/go-encrypt-decrypt-aes-tutorial/)
And many more
