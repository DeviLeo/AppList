# AppList
List all apps with details on __jailbroken__ i-Devices.  

You can get __\<Bundle URL\>__ and __\<Data Container URL\>__ from the list with __"-v"__ argument.

## AppList with UI
#### Notices
Tested on jailed iOS 10.  
Tested on __jailbroken iOS 11__.  
Not tested on tvOS.  

#### Usage
Just run it.

#### How to install on iOS 11
1. scp __AppList.app__ file to the device.
```bash
scp -r -P 22 AppList.app root@<device ip>:~/
```
2. ssh device and use jtool to sign __AppList__.
```bash
# ssh
ssh root@<device ip> -p 22

# get the entitlement from AppStore.app
jtool --ent /Applications/AppStore.app/AppStore > appstore.ent

# sign
jtool --sign --ent appstore.ent --inplace AppList.app/AppList
```
3. cp __AppList.app__ to __/Applications__ folder
```bash
cp -rf AppList.app /Applications/
```
4. Restart Springboard
```bash
killall -9 SpringBoard
uicache
```

## AppList for console
#### Notices
Tested on __jailbroken iOS 11__.  
Not tested on tvOS.  

#### Usage
```bash
applst -vausoh
applst <Bundle ID>

-v List apps with details
-a List all apps
-u List user apps
-s List system apps
-o List other apps
-h Show help
```

#### How to install on iOS 11
1. scp __AppList__ file to the device.
```bash
scp -r -P 22 AppListConsole.app/AppListConsole root@<device ip>:~/applst
```
2. ssh device and use jtool to sign __AppList__.
```bash
# ssh
ssh root@<device ip> -p 22

# get the entitlement from /jb/bin/ls
jtool --ent /jb/bin/ls > plat.ent

# sign
jtool --sign --ent plat.ent --inplace applst
```
3. cp __applst__ to __/jb/usr/bin/__ folder
```bash
cp applst /jb/usr/bin/
```
