#= -------------------------------------------------------------------------
# @file tank_animation.jl
#
# @date 11/20/17 13:45:25
# @author Martin Noblia
# @email martin.noblia@openmailbox.org
#
# @brief
# Esto es una prueba para hacer que una animacion de llenado y vaciado
   de un tanque con Julia y SFML
   lo que quiero utilizar es un rectangle que varie su altura e insertarlo
   en una imagen
# @detail
#
#  Licence:
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
---------------------------------------------------------------------------=#
using SFML

const height = 600
const  width = 600
window = RenderWindow(VideoMode(height, width), "Square", window_defaultstyle)
set_framerate_limit(window, 60)
altura = 0
h_max = 100
Δh = .3
Δt = .2
event = Event()
\alu
texture = Texture("/home/elsuizo/bitmap.png")
square = RectangleShape()
set_size(square, Vector2f(80, 0))
set_position(square, Vector2f(height/2, width/2))
set_origin(square, Vector2f(0, 0))
set_fillcolor(square, SFML.black)
set_outlinecolor(square, Color(4, 200, 127))
set_outline_thickness(square, 2)

#= set_texture(square, texture) =#
clock = Clock()
restart(clock)
while isopen(window)
    while pollevent(window, event)
        if get_type(event) == EventType.CLOSED
            close(window)
        end
    end
    if as_seconds(get_elapsed_time(clock)) >= Δt
       altura += Δh
       set_size(square, Vector2f(60, -altura))
       println("add!!!")
      if altura == h_max
         altura = 0
      end
      restart(clock)
    end
    clear(window, SFML.white)
    draw(window, square)
    display(window)
end



