## Add new native module
When the engine is no longer unique to your feeling, and you are too lazy to [build docker](https://github.com/thetrung/build_defold_instruction/blob/master/how_to_Docker.md) for `native extension`.

Here is how to add new native module into Defold Engine.

## Benefit
Unlike native extension, where you can just paste link and fetch the module via internet or call your local Extender Docker to build it, native module is built directly into `dmengine`. This is good when you don't want to build the Docker yourself for your modified Defold Editor.

## Steps
1. Add your module folder to /engine with structure :

            --- src
            -----|
            ------- your_module.cpp
            ------- wscript
            --- wsscript

2. `/src/wscript` content can be ref by searching 'iap' but keywords when editing is :
- Main source name : 

      source = 'tapticengine.cpp'.split()
    
- Custom stuff for each platform :

        platforms = ['arm.*?darwin', 'x86_64-ios']
            for p in platforms:
                if re.match(p, bld.env.PLATFORM):
                    source += ['tapticengine.mm'] // Add iOS support here
                    break
                
- Add lib if needed, target = your_module_name :

        bld.new_task_gen(features = 'cxx cstaticlib',
                        includes = '.',
                        source = source,
                        target = 'TapticEngine')
                    
- Add doc here :

        apidoc_extract_task(bld, ['tapticengine.cpp'])
        
- Build Docs again :

        build.py build_docs
        
#### *Most important things*

1.Waf config : 

        PREFIX=$DYNAMO_HOME waf configure --platform=x86_64-darwin

2.Extender/Docker support :
- Once you have done running your module in local build and nothing seem to be wrong
- Remember to add module name + symbol into `defold/share/extender/build.yml` before bundling your editor.
- This help your local server ( which rely on DYNAMO_HOME ) to also include your newly added module, while adding other native extensions.
