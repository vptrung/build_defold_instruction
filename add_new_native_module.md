## Add new native module
Here is how to add new native module into Defold Engine.

## Benefit
Unlike native extension, where you can just paste link and fetch the module via internet or your local Extender Docker, native module is built directly into `dmengine`. This is good when you don't want to build the Docker yourself for your modified Defold Editor.

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
    
    
