#= -------------------------------------------------------------------------
# @file sfml_tests.jl
#
# @date 11/17/15 18:10:46
# @author Martin Noblia
# @email martin.noblia@openmailbox.org
#
# @brief
# move a line with the arrows keys (right, left, up, down)
# @detail
#
  Licence:
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

# setup the window with some anti aliasing
settings = ContextSettings()
settings.antialiasing_level = 3
window = RenderWindow(VideoMode(800, 600), "Test", settings, 
                    window_defaultstyle)

# create a event type
event = Event()

# create a rectangle 
rect = RectangleShape()
set_size(rect, Vector2f(10, 100))
set_fillcolor(rect, SFML.green)
set_position(rect, Vector2f(400, 300))

direction = 0
moving = false
in_y = false
in_x = false

while isopen(window)
    # check for events
    while pollevent(window, event)
        # if close window 
        if get_type(event) == EventType.CLOSED
            close(window)
        end
        # move left
        if get_type(event) == EventType.KEY_PRESSED
            if get_key(event).key_code == KeyCode.LEFT
                moving = true
                direction = -1
                in_x = true
            end
        end
        # move right
        if get_type(event) == EventType.KEY_PRESSED
            if get_key(event).key_code == KeyCode.RIGHT
                moving = true
                direction = 1
                in_x = true
            end
        end
        # move up
        if get_type(event) == EventType.KEY_PRESSED
            if get_key(event).key_code == KeyCode.DOWN
                moving = true
                direction = 1
                in_y = true
            end
        end
        # move down
        if get_type(event) == EventType.KEY_PRESSED
            if get_key(event).key_code == KeyCode.UP
                moving = true
                direction = -1
                in_y = true
            end
        end
        
    end
    if moving && in_x
        move(rect, Vector2f(1*direction,0))
    end
    if moving && in_y
        move(rect, Vector2f(0, 1*direction))
    end

    clear(window, SFML.black)
    draw(window, rect)
    display(window)
    moving = false
    in_y = false
    in_x = false
end

