## Overview 
The process is like 3 major steps : 
- Define new proto message
- Add Set-Property function
- Add Get-Property function

Remember that in Defold, it goes from Lua->component_wrapper->native

## Add New Property
- Look for proto file, in this case, we add new `body_position` into `physics_ddf.proto` :

      message RequestBodyPosition {}

      message BodyPositionResponse
      {
          required dmMath.Vector3 body_position     = 1;
      }

- Rebuild the Engine, it will generate new header that contains above type in `physics_ddf.h`

## Set Property 

- Look for this function in `comp_collision_object.cpp` :

      dmGameObject::PropertyResult CompCollisionObjectSetProperty(const dmGameObject::ComponentSetPropertyParams& params)
      {
        //...
      }

- Add your `PROP_BODY_POSITION` on top of class, under namespace area :

      static const dmhash_t PROP_BODY_POSITION = dmHashString64("body_position");

- Add new part below near-ending :

      else if (params.m_PropertyId == PROP_BODY_POSITION)
        {
            if (params.m_Value.m_Type != dmGameObject::PROPERTY_TYPE_VECTOR3)
                return dmGameObject::PROPERTY_RESULT_TYPE_MISMATCH;
            if (physics_context->m_3D)
            {
                // undefined !
            }
            else
            {
                dmPhysics::SetWorldPosition2D(physics_context->m_Context2D,component->m_Object2D,
                                              Vectormath::Aos::Vector3(
                                                  params.m_Value.m_V4[0], 
                                                  params.m_Value.m_V4[1], 
                                                  params.m_Value.m_V4[2]));
            }
            return dmGameObject::PROPERTY_RESULT_OK;
        }
        
 - In case, that you don't have certain function like `dmPhysics::SetWorldPosition2D`, you will need to implement and add to the header.
 
# Get Property

- Look for this function in `comp_collision_object.cpp` :

      dmGameObject::PropertyResult CompCollisionObjectGetProperty(const dmGameObject::ComponentGetPropertyParams& params, dmGameObject::PropertyDesc& out_value)
      {
        //...
      }

- Add new part below near-ending :

      else if (params.m_PropertyId == PROP_BODY_POSITION)
        {
            if (physics_context->m_3D)
            {
                Vectormath::Aos::Vector3 vec3 = Vectormath::Aos::Vector3(
                    dmPhysics::GetWorldPosition3D(physics_context->m_Context3D, component->m_Object3D));
                out_value.m_Variant           = dmGameObject::PropertyVar(vec3);
            }
            else
            {
                Vectormath::Aos::Vector3 vec3 = Vectormath::Aos::Vector3(
                dmPhysics::GetWorldPosition2D(physics_context->m_Context2D, component->m_Object2D));
                out_value.m_Variant           = dmGameObject::PropertyVar(vec3);
            }
            return dmGameObject::PROPERTY_RESULT_OK;
        }
