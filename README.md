## ::DEFOLD ENGINE + EDITOR BUILD ON MACOS

#### Required Tools : 
- HomeBrew 
- Python 2.7.16 - 64 bit *( 32 bit won’t run )*
- Wget 
- Pip

        curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
        python get-pip.py

- Setuptools 
- JDK 11.0.1

        https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_osx-x64_bin.tar.gz

- IntelliIDEA Community + Cursive

### Instruction

##### 1. Git Clone Defold from GitHub  
*- Download won’t work.*

##### 2. Download packages
- Run through all scripts in `/scripts/package/`
- From `/defold` folder :
        
        ./scripts/package/package_emscripten.sh 
        ./scripts/package/package_xcode_and_sdks.sh
        ./scripts/package/package_android_ndk.sh 
        ./scripts/package/package_android_sdk.sh

##### 3. Install JDK 11.0.2
- download + extract somewhere

        sudo cp -R jdk-11.0.1.jdk /Library/Java/JavaVirtualMachines/
        /usr/libexec/java_home -V
        /usr/libexec/java_home -v 11.0.1

##### 4. Install install_ems & copy .emscripten

        ./scripts/build.py install_ems --package-path=./local_sdks
        cp ./tmp/dynamo_home/ext/SDKs/emsdk-1.39.16/.emscripten ~/

##### 5. Run Shell to init Environment :
        
        ./scripts/build.py shell --platform=x86_64-darwin --package-path=./local_sdks/

##### 6. Re-install setuptools/Python 64-bit if got “ContextualZipFile Error” :
Check Python PATH, if not exist then:

- MacOS Mojave and below :
        
        PATH=$PATH:~/Library/Python/2.7/bin >> ~/.bash_profile
        source ~/.bash_profile

- MacOS Catalina or later :

        PATH=$PATH:~/Library/Python/2.7/bin >> ~/.zshrc
        source ~/.zshrc

##### 7. Change XCode version 

        XCODE_VERSION & PACKAGES_XCODE_TOOLCHAIN into current using version 
        ( check downloaded XCODE in ./local_sdks )

##### 8. Run Install Extension :

        ./scripts/build.py install_ext --platform=x86_64-darwin --package-path=./local_sdks

##### 9. Install lacking stuffs :

        brew install wget curl p7zip ccache dos2unix cmake boost boost-python
        pip install httpserver boost wheel protobuf google
        
- if Get protobuf error :
        
        pip install --no-binary=protobuf protobuf
        pip install google-cloud google google-api-python-client protobuf

##### 10. Build Engine : 

        ./scripts/build.py build_engine --platform=x86_64-darwin --skip-tests -- --skip-build-tests

##### 11. Lein Init 
- Run Shell again if new Terminal :

        ./scripts/build.py shell --platform=x86_64-darwin --package-path=./local_sdks/
        sudo ./scripts/build.py build_builtins
        sudo ./scripts/build.py build_bob --skip-tests
        cd editor
        lein init

##### 12. Run Editor 

        lein run

##### 13. Bundle Editor

        ./editor/scripts/build.py shell --platform=x86_64-darwin --package-path=./local_sdks/
        ./editor/scripts/bundle.py bundle  --platform=x86_64-darwin --version=1.2.169 --engine-artifacts=dynamo-home
