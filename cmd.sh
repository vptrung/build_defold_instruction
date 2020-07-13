## CMD.SH content
______________________________________________
Shorthand to build Defold Engine
@thetrung | July 2020

__________________[COMMAND]___________________
sh cmd.sh --setup | -s : for environment setup
sh cmd.sh --engine| -e : for building engine alone
sh cmd.sh --editor| -e : for building editor + launch
sh cmd.sh --misc  | -m : for building bob + builtin
sh cmd.sh --fast  | -F : to build engine/editor + launch
sh cmd.sh --run   | -r : for running editor
sh cmd.sh --bundle| -B : for bundling editor into ./editor/release
__________________[SHORTHAND]___________________
sh cmd.sh --shell_mojave   | -sm : to run shell_defold on Mojave
sh cmd.sh --shell_catalina | -sc : to run shell_defold on Catalina
sh cmd.sh --cd_mojave      | -cdm : add defold path so you can just call: cd_defold
sh cmd.sh --cd_catalina    | -cdc : add defold path so you can just call: cd_defold
______________________________________________
You can also run each script separately as :
sh setup_env.sh
sudo ./scripts/build.py build_engine --platform=x86_64-darwin --skip-tests -- --skip-build-tests
sudo ./scripts/build.py build_bob --skip-tests
sudo ./scripts/build.py build_builtins
(cd editor/;lein init)
(cd editor/;lein run)
sh bundle_editor.sh

## NOTE 
______________________________________________
- Normal workflow after environment setup's done is like : 

1. cd to your folder : `cd_defold`
2. run shell inside  : `shell_defold`
3. build & run       : `sh cmd.sh --F` 
4. bundle            : `sh cmd.sh --bundle`
