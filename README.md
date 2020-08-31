## ::DEFOLD ENGINE + EDITOR BUILD ON MACOS

#### Required Tools : 
- Python 2.7.16 - 64 bit *( 32 bit won’t run )*
- HomeBrew 
- Pip

        curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
        python get-pip.py

- IntelliIDEA Community + Cursive

### Instruction

##### 1. Git Clone Defold from GitHub  
*- Download won’t work.*


##### 2. Install JDK 11.0.1 
- [Link for macOS](https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_osx-x64_bin.tar.gz) 

        tar xzvf openjdk-11.0.1_osx-x64_bin.tar.gz
        sudo cp -R jdk-11.0.1.jdk /Library/Java/JavaVirtualMachines/
        /usr/libexec/java_home -V
        /usr/libexec/java_home -v 11.0.1

- [Link for Linux](https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz)

        tar xzvf openjdk-11.0.1_linux-x64_bin.tar.gz
        sudo mv jdk-11.0.1 /usr/lib/jvm/jdk-11.0.1 
        sudo ln -s /usr/lib/jvm/jdk-11.0.1/bin/java* /bin/

##### 3. Install lacking stuffs :

### === MacOS ===

        brew install wget curl p7zip ccache dos2unix cmake boost boost-python
        pip install httpserver boost wheel protobuf google
        
- if Get protobuf error :
        
        pip install --no-binary=protobuf protobuf
        pip install google-cloud google google-api-python-client protobuf
        
- If can’t find *GCC* or *G++* then re-check `waf_dynamo.py` and `build.py` 

        for XCODE_VERSION and the PACKAGES_XCODE_TOOLCHAIN path.
        
- `build.py` will automatically detect XCODE_VERSION & PACKAGES_XCODE_TOOLCHAIN inside `./local_sdks`

### === Linux ===
- install easy_install

        sudo sh -c "echo \#\!/usr/bin/env bash > /usr/local/bin/easy_install" && \
        sh -c "echo python /usr/lib/python2.7/dist-packages/easy_install.py $\* >> /usr/local/bin/easy_install" && \
        chmod +x /usr/local/bin/easy_install

- install packages 

        sudo apt-get install -y --no-install-recommends libssl-dev openssl libtool autoconf automake build-essential uuid-dev libxi-dev libopenal-dev libgl1-mesa-dev libglw1-mesa-dev freeglut3-dev libx11-dev && \
        sudo apt-get install wget curl p7zip ccache lua5.1 libglfw3-dev && \
        sudo apt-get install xcb libxcb-xkb-dev x11-xkb-utils libx11-xcb-dev libxkbcommon-x11-dev
        
- get [clang 9.0.0 package for Ubuntu](https://releases.llvm.org/9.0.0/clang%2bllvm-9.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.zx)
        
        
- to fix clang 9.0.0 can't find libtinfo5 :
        
        sudo apt update && sudo apt install -y libtinfo5
        
- find [XCodeDefault11.5 somewhere](https://drive.google.com/file/d/1sC3sBrN3DegjvjPP9Cc-m1oCsxijaXS1/view?usp=sharing)
        
- to fix lacking any library :

        sudo apt install apt-file
        
        # then search with it
        apt-file search glfw.h
    
        
##### 4. Download packages
- Install XCode 
- Install Header, on Mojave :

        sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /

- Run through all scripts in `/scripts/package/` by 

        sh cmd.sh --setup

- Or from `/defold` folder :
        
        ./scripts/package/package_emscripten.sh 
        ./scripts/package/package_xcode_and_sdks.sh
        ./scripts/package/package_android_ndk.sh 
        ./scripts/package/package_android_sdk.sh

- Then install install_ems & copy .emscripten

        ./scripts/build.py install_ems --package-path=./local_sdks
        cp ./tmp/dynamo_home/ext/SDKs/emsdk-1.39.16/.emscripten ~/
        
- Copy all packed/downloaded archives in `local_sdks` -> `packages`

        cp -r local_sdks packages
        
##### 5. Run Shell to init Environment :
        
        ./scripts/build.py shell --platform=x86_64-darwin --package-path=./local_sdks/
        
* This thing will be called again alot, so use this to save time :

        echo "alias shell_defold='./scripts/build.py shell --platform=x86_64-darwin --package-path=./local_sdks/'" >> ~/.zshrc
        
* Or just run `sh cmd.sh --shell catalina` ( or mojave ) for that stuff.
        
Put those lines into your `~/.bash_profile` or `~/.zshrc`,easiest way is to use `sh cmd.sh --shell_mojave`

##### 6. Re-install setuptools/Python 64-bit if got “ContextualZipFile Error” :
Check Python `PATH`, if not exist then:

- MacOS Mojave and below :
        
        PATH=$PATH:~/Library/Python/2.7/bin >> ~/.bash_profile
        source ~/.bash_profile

- MacOS Catalina or later :

        PATH=$PATH:~/Library/Python/2.7/bin >> ~/.zshrc
        source ~/.zshrc

##### 7. Run Install Extension :

        ./scripts/build.py install_ext --platform=x86_64-darwin --package-path=./packages

- Taking note at this step : making wrong path will cause non-sense error.
- Should have copy some libs like iPhoneOS and XCodeToolchain to `/packages` from `/local_sdks`

##### 8. Build Engine : 

        ./scripts/build.py build_engine --platform=x86_64-darwin --skip-tests -- --skip-build-tests

##### 9. Lein Init 
- Run Shell again if new Terminal :

        ./scripts/build.py shell --platform=x86_64-darwin --package-path=./local_sdks/
        sudo ./scripts/build.py build_builtins
        sudo ./scripts/build.py build_bob --skip-tests
        cd editor
        lein init

##### 10. Run Editor 

        lein run

##### 11. Bundle Editor
- Originally from `defold` :

        ./scripts/build.py shell --platform=x86_64-darwin --package-path=./local_sdks/
        ./scripts/bundle.py build  --platform=x86_64-darwin --version=1.2.169 --engine-artifacts=dynamo-home
        ./scripts/bundle.py bundle  --platform=x86_64-darwin --version=1.2.169 --engine-artifacts=dynamo-home
        
- Or we can use `cmd.sh` :

        sh cmd.sh --bundle 1.2.171.14

- If error on SSL FAILED : 
Check for current python version in `/Applications/Python\` then run :

        /Applications/Python\ 2.7/Install\ Certificates.command

- The result will be opened automatically after done, at :

        ./editor/release/Defold-x86_64-darwin.zip 
