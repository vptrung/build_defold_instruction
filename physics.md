### :: Message 
Built-in Defold properties/function 

*properties :*

- angular_damping 	
- angular_velocity 	
- linear_damping 	
- linear_velocity 	
- mass

*function :*
- apply_force

### :: Modification  

*properties :*
- body_angle

      go.get("#body", "body_angle")  
      go.set("#body", "body_angle", 1)

- body_position

      go.get("#body", "body_position")  
      go.set("#body", "body_position", vmath.vector3(0.1, 0.15, 0))

*function :*

- copy_state:

      physics.set_master_body("ball1/Ball#body", "master_ball/Ball#body")
      physics.copy_state(collisionobject, physics.COPY_LINEAR_VEC)
      physics.set_copy_disable() 

- set_allow_sleep:

      physics.set_allow_sleep("#body", true)

- set_controllable: 

      physics.set_controllable (“#body”, true)
      -- mark a body to be updated along world step.

- set_alpha_value: 

      physics.set_alpha_value(“#body”, alphaX, alphaY, rotationZ)
      -- alpha value {x:y} to be updated via world step.

- set_gravity_scale

      physics.set_gravity_scale("#body", 1.5)

- apply_force_impulse
 
      force = vmath.vector3(0,1000,0)
      position = go.get_world_position()
      msg.post("#body", "apply_force_impulse", force, position)

- physics.config ( stepIteration, velocityIteration, positionIteration )

      function init(self)
        physics.set_step_per_frame(8, 16, 8)
      end
