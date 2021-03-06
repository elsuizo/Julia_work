#= -------------------------------------------------------------------------
# @file phase_portrait_mouse_event.jl
#
# @date 06/19/16 18:08:27
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
@pyimport scipy.integrate as integrate
@pyimport matplotlib as mpl

# function f(Y,t)
#     y1, y2 = Y
#     return [y2, -sin(y1)]
# end
#
y1 = range(-2, 8, step=100)
y2 = range(-2, 2, step=100)
#
# Y1 = y1'
# Y2 = y2'
#
# t = 0
#
# u, v = zeros(size(Y1)), zeros(size(Y2))
#
# NI, NJ = size(Y1)
#
# for i in 1:(NI-1)
#    for j in 1:(NJ-1)
#         x = Y1[i, j]
#         y = Y2[i, j]
#         ẏ = f([x, y], t)
#         u[i,j] = ẏ[1]
#         v[i,j] = ẏ[2]
#     end
# end

fig, ax = plt[:subplots]()
Q = quiver(Y1, Y2, u, v, color="r")

title("Phase portrait in Julia.")
xlabel(L"$y_1$")
ylabel(L"$y_2$")
xlim([-2, 8])
ylim([-4, 4])

function on_button_press(event)

    t_sim = LinRange(0, 50, 200)
    x, y = event[:xdata], event[:ydata]
    x₀ = [x, y]
    ys = integrate.odeint(f, x₀, t_sim)
    plt[:plot](ys[:,1], ys[:,2], "k-", markersize=10) # path
    plt[:plot]([ys[1,1]], [ys[1,2]], "o", markersize=10) # start
    plt[:plot]([ys[-2,1]], [ys[-2,2]], "s", markersize=10) # end
    fig[:canvas][:draw]()

end

fig[:canvas][:mpl_connect]("button_press_event", on_button_press)
plt[:show]()
