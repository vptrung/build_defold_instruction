# install `ipa` using command line

* using `ideviceinstaller` which can be installed using `brew install ideviceinstaller`

```sh
# list installed app on the connected device
# it also lists the identifier of the installed packages
ideviceinstaller -l

# install ipa
ideviceinstaller -i <your-package.ipa>

# uninstall app
ideviceinstaller -U <your-app-id>
```
