## Issue : Can't run after built to iOS platform

### Symtoms
Now you have successfully built the dmengine's app from your **custom built defold**, but the App didn't run after installed to device successfully.
You cry but no one can help. 
So you found my guide :)

### Treatment

1. run this to get `entitlements.plist` file :

        codesign -d --entitlements :- your-fucking-app.app >> entitlements.plist

2. remove 2 lines in entitlements.plist :

        <key>keychain-access-groups</key>
        <string>com.apple.token</string>

3. put back in same folder with `game.project` & add to `Entitlement` section.

4. re-bundle iOS again.

Enjoy :)

* Note : if you still see app crash, in our rare case of modifying `.collection` or generate defold file system, the format may not be right for containing integer instead of `float` everywhere like 1 instead of 1.0.
