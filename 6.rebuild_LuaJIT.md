## Rebuild LuaJIT 

## 1. Build it
- Run this :

      ./share/ext/luajit/build_luajit.sh x86_64-darwin

## 2. Unzip and copy to 

      tmp/dynamo_home/ext/lib
      
## 3. Rebuild Engine 

      sh cmd.sh --engine

## Modify LuaJIT
- in case you want to play with this, look into my `common.sh` and `build_luajit.sh` for pausing the flow and adding my own modication. You can use patching too.
