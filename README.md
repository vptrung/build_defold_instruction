## ::DEFOLD ENGINE + EDITOR BUILD ON MOJAVE

#### Required Tools : 
- HomeBrew 
- Python 2.7.16 - 64 bit *( 32 bit won’t run )*
- Wget 
- Pip
- Setuptools 
- JDK 11.0.2
- IntelliIDEA Community + Cursive

### Instruction

##### 1. Git Clone Defold from GitHub  
*- Download won’t work.*

##### 2. Download packages
- Run through all scripts in /scripts/package/

##### 3. Install JDK 11.0.2
- download + extract somewhere

        sudo cp -R jdk-11.0.2.jdk /Library/Java/JavaVirtualMachines/
        /usr/libexec/java_home -V
        /usr/libexec/java_home -v 11.0.2

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
        pip install httpserver boost boost-python wheel 

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
