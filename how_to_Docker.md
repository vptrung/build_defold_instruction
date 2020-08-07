## Defold Extender on Docker 

## 1. Build Docker 

- Full fill your ./local_sdks

      install all scripts inside `/scripts/package/` especially the `package_cctools.sh`

- Clone git repo

      git clone https://github.com/defold/extender.git
    
- Install Docker

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

- Now, remember to download the clang 9.0.0 for Ubuntu 16.04 from google, and put it under your ./local_sdks

- About ccTools, try this with Docker turned on :

      defold$ ./scripts/docker/build.sh
      defold$ ./scripts/docker/run.sh
      ubuntu$ ./scripts/package/package_cctools.sh

- We can start a server inside `/local_sdks` by :

      (cd ./local_sdks;python -m SimpleHTTPServer)
      # it will now serve under 0.0.0.0 port 8000
    
- Now from /extender, run your build.sh as :

      ./server/scripts/build.sh -xtest
     
- Wait to see if your other python server send GET for clang..if it got that lib then we may pass.

## 2. Run 
- After finished build Docker image, run this :

      shell_defold_x86_64
      # then <cd> to /extender
      
      ./server/script/run-local.sh
      # => server will start at http://localhost:9000
      
- The reason we need to run shell, is for `DYNAMO_HOME` to be detected on extender Docker.

- Now we can start building native extension !

