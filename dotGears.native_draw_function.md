## Native Draw Function

    local render = "@render:"
    local color_red = vmath.vector4(1, 0, 0, 1)

## 1. draw_line

    msg.post(render, "draw_line",{
        start_point = vmath.vector3(300, 0, 0),
        end_point = vmath.vector3(300, 2000, 0),
        color = color_red
      }) -- Vertex = 2

## 2. draw_circle

    msg.post(render, "draw_circle", {
        radius = 400,
        segment = 64,
        angle_begin = 0,
        angle_end = 360,
        position = vmath.vector3(self.x, self.y, 0),
        color = color_red
      })


## 3. draw_rectangle

    msg.post(render, "draw_rectangle", {
      v1 = vmath.vector3(200, 0, 0),
      v2 = vmath.vector3(150, 300, 0),
      v3 = vmath.vector3(450, 300, 0),
      v4 = vmath.vector3(400, 0, 0),
      color = color_red
    }) -- Vertex = 6
