## Defold Extender on Docker 

## 1. Build Docker 

- Wash your hand & Install Docker

- Full fill your `./local_sdks` by installing all scripts inside `/scripts/package/`
- **Note:** `package_cctools.sh` and `package_android_sdk.sh` need to be run on the *Ubuntu 18.04 Docker*.
     
      # on your host machine:
      defold$ ./scripts/docker/build.sh
      defold$ ./scripts/docker/run.sh
      
      # on Docker:
      ubuntu$ ./scripts/package/package_cctools.sh
      ubuntu$ ./scripts/package/package_android_sdk.sh

- Clone git repo

      git clone https://github.com/defold/extender.git
    
- Run Build inside /extender

      ./server/scripts/build.sh
    
- Now it will fail, but take one docker container and turn on CLI :

      apt-get update -y
      apt-get install -y netcat iputils
    
- Use netcat to check which IP you can go through from inside docker container :

      netcat host.docker.internal 8000
      > type something
    
- Then Ping to see IP :

      ping host.docker.internal 
    
- Now, copy that IP into your /extender/docker/docker-base/ as :

      DM_PACKAGE_URL=http://192.168.65.2:8000
    
- The IP normally, will be something like that, as Docker default mask is `192.168.65.0/24`

- Now, remember to download the `clang 9.0.0` for `Ubuntu 16.04` from google, and put it under your `./local_sdks`

- We start a server inside `/local_sdks` by :

      (cd ./local_sdks;python -m SimpleHTTPServer)
      # it will now serve under 0.0.0.0 port 8000
    
- Now from `/extender`, run your build.sh as :

      ./server/scripts/build.sh -xtest
     
- Wait to see if your other python server send GET for `clang-9.0.0` and various packages.. if it got that lib then we may pass.

## 2. Run 
- After finished build Docker image, run this :

      shell_defold_x86_64
      # then <cd> to /extender
      
      ./server/script/run-local.sh
      # => server will start at http://localhost:9000
      
- The reason we need to run shell, is for `DYNAMO_HOME` to be detected on extender Docker.

- Now we can start building native extension !

## 3. Clean up & save to hub
- clean up local mess :

      docker system prune
      
- save to hub :

      # to show your current images 
      docker images 
      
      REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
      extender/extender   latest              e85788d0e372        3 minutes ago       8.62GB
      extender-base       latest              aafb68a1e217        3 minutes ago       8.55GB
      builder/ubuntu      latest              30fee6a3146d        44 minutes ago      1.64GB
      ubuntu              16.04               fab5e942c505        2 weeks ago         126MB
      ubuntu              18.04               2eb2d388e1a2        2 weeks ago         64.2MB
      
      # tag your build 
      docker tag e85788d0e372 yourhubusername/verse_gapminder:firsttry
      
      # upload 
      docker push yourhubusername/verse_gapminder
      
      # pull from other machine with Docker
      docker pull yourhubusername/verse_gapminder:firsttry
