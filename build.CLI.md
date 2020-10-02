### :: Defold CLI usage 


**1. Pull latest from Dev**


**2. Add path for bob.jar :** 

    sh cmd.sh --bob catalina


**3. To resolve & fetch libs**

    bob resolve --email <your-email> --auth <password>

**4. build/bundle app**

    bob --build-server http://192.168.0.100:9000 --archive --platform <target> distclean build bundle --debug
