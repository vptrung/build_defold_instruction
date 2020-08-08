## Overlap Alpha Blending 


### 1. Problem 
When you have 2 alpha-based images, and want them to "merge" together instead of bolder color inbetween the intersection.

### 2. How to solve it 
I did try modifying the blending setting by some native openGL in defold, but things didn't work out like it did in other engine.
The proper way to do this is by using Defold render pipeline :

    1. Clear by empty color bit
    2. Draw your image to a texture
    3. Draw that texture to a buffer
    
### 3. Sample code 

    local clear_bit = {
        [render.BUFFER_COLOR_BIT] = vmath.vector4(0, 0, 0, 0), 
        [render.BUFFER_DEPTH_BIT] = 1,
        [render.BUFFER_STENCIL_BIT] = 0
    }

    -- Call in the end of init (self)
    function setup_target(self)
        self.target = render.render_target("layer0", {[render.BUFFER_COLOR_BIT] = self.color_params})
    end

    function draw_to_texture(self, predicate)
        render.enable_render_target(self.target) 

        render.clear(clear_bit) -- clear with buffer color ZERO
        render.draw(predicate)

        render.disable_render_target(self.target) 
    end

    function draw_to_buffer(self, r, g, b, a)
        render.enable_texture(0, self.target, render.BUFFER_COLOR_BIT)

        local constants = render.constant_buffer()
        constants.tint = vmath.vector4(r, g, b, a)
        render.draw(self.screen_buffer_pred, constants) -- draw with buffer color

        render.disable_texture(0, self.target, render.BUFFER_COLOR_BIT)
    end
    
    
So in `update(self)` of your `render_script`, you just need to call :

    draw_to_texture(self, your_predicate)
    draw_to_buffer(self, 0, 0, 0, 0.5)
