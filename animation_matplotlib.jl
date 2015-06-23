#= -------------------------------------------------------------------------
# @file animation_matplotlib.jl
#
# @date 2015
# @author Martin Noblia
# @email martin.noblia@openmailbox.org
#
# @brief
#
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
using PyPlot
using PyCall
#@pyimport matplotlib.pyplot as plt
@pyimport matplotlib.animation as anim 

fig = plt.figure()
#fig[:set_dpi](100)
fig[:set_size_inches](7, 6.5)
ax = plt.axes(xlim=(0, 10), ylim=(0, 10))
global patch = plt.Circle((5, -5), 0.75, fc="r")

function init()
    global patch
    patch[:center] = (5, 5)
    ax[:add_patch](patch)
    return (patch, None)
end
step = 1
function animate(i)
    global patch
    k = i + 1
    x, y = patch[:center]
    x = 5 + 3 * sin(deg2rad(k * step))
    y = 5 + 3 * cos(deg2rad(k * step))
    patch[:center] = (x, y)
    return (patch, None)

end

a = anim.FuncAnimation(fig, animate, init_func=init, frames=360, interval=20)

plt.show()
