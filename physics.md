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
      go.set("#body", "body_position", { body_position = vmath.vector3(2,10,0) })

*function :*
- apply_force_impulse
 
      force = vmath.vector3(0,1000,0)
      position = go.get_world_position()
      msg.post("#body", "apply_force_impulse", force, position)

- physics.set_step_per_frame(stepIteration, velocityIteration, positionIteration)

      function init(self)
        physics.set_step_per_frame(8, 16, 8)
      end
