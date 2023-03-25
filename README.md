# RustDesk installer Powershell Script

*Forked from [Simple install script for RustDesk to point to your own server. Can be used in a GPO startup script. · GitHub](https://gist.github.com/quonic/db3f97d42ea6ae853e3c2120864d8b21)*

A simple script which allows to install RustDesk Client with custom IP Address and PublicKeyString, ready to deploy in GPO.

## How-to use ?

- Replace the IP with your RustDesk server at the line 5 :

```powershell
$IpAddress = "127.0.0.1"
```

- Replace the PublicKeyString by the key on your RustDesk Server at the line 7 :

```powershell
$PublicKeyString = "12345678"
```

Launch and that's all, or put it in a GPO 🎉
