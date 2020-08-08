## Message Passing System 
You send a data table to an object address to do anything you want.


## What make Defold unique 
It isn't alike to other game engine, but an `asynchronous engine`. 
Which mean, it won't execute your order directly but processing a queue of messages that you pass to the system.


## Why message passing is preferred ?
Because Defold want to be fast with native C++ `dmengine` underneath, while remaining less stress on slow-scripting with Lua. Think of Defold as NodeJS/Express architecture, where system is event-driven with a message processing ring.

## How it work 
- You send Defold a message via `msg.post`, targetting a certain object address, mostly from `hash("#something")` or 'msg.url`. 
- Then `dmengine` will get your mail, process and call the function with the data you passed on. 
- It can return back what you want too.

## How to implement it
1. Define your function description in `engine\gamesys\proto\something.proto`

        message ApplyForce
        {
            required dmMath.Vector3 force       = 1;
            required dmMath.Point3  position    = 2;
        }
        
Remember to comment alike to other messages style.

2. Rebuild the Engine

         ./scripts/build.py build_engine --platform=x86_64-darwin --skip-tests -- --skip-build-tests

3. Add your message processing part into `com_collision_object.cpp` :

        dmGameObject::UpdateResult CompCollisionObjectOnMessage(const dmGameObject::ComponentOnMessageParams& params)
        {
          //... Code....//
        }
        
Should be something like :


     else if (params.m_Message->m_Id == dmPhysicsDDF::ApplyForce::m_DDFDescriptor->m_NameHash)
     {
          dmPhysicsDDF::ApplyForce* af = (dmPhysicsDDF::ApplyForce*) params.m_Message->m_Data;
          if (physics_context->m_3D)
          {
              dmPhysics::ApplyForce3D(physics_context->m_Context3D, component->m_Object3D, af->m_Force, af->m_Position);
          }
          else
          {
              dmPhysics::ApplyForce2D(physics_context->m_Context2D, component->m_Object2D, af->m_Force, af->m_Position);
          }
     }        

4. Rebuild the engine & `sh cmd.sh --copy <your-host-platform>` to copy dmengine into your running editor.
