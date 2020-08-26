## Catalina Build Engine Common Error 
what scared us to upgrade further, now is gone.
thanks to someone that was hard working ;))

### Reason

#### 1.firstly, it's because of wrong script execution, but this is a very minor problem, as everyone can run by defold guide.

=> Fixed in new update ( because now I had new environment to actually look into it and fix )

#### 2. second, is because of `package_xcode_and_sdk.sh` can't output the right library that trimming XCode into :

    MacOS10.15.sdk
    iPhoneOS13.5.sdk
    iPhoneSimulator13.5.sdk
    XcodeDefault11.5.xctoolchain

- all of them are actually folders without version inside `XCode.app`, which is now, added to `packages` to save time.

#### 3. Catalina changed SDK headers location 
- Although this seem like the reason at first, but it's not since Defold compiling based on what it has inside *DYNAMO_HOME*. 
- We can still make it right for other purpose, even not for Defold, from [HERE](https://discourse.brew.sh/t/clang-can-no-longer-find-usr-include-header-files-fatal-error-stdlib-h-file-not-found/4523/8)

#### 4. SIP may be turned off when needed for unsign app

### Conclusion
- Checkout new version on defold/dev.
