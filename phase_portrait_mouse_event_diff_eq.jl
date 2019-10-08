#= -------------------------------------------------------------------------
# @file phase_portrait_mouse_event_diff_eq.jl
#
# @date 09/27/19 12:03:34
# @author Martin Noblia
# @email mnoblia@disroot.org
#
# @brief
#
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
using DifferentialEquations
using PyPlot
using PyCall
@pyimport matplotlib as mpl

function f(dx, x, p, t)
   dx[1] = x[2]
   dx[2] = -sin(x[1])
end

fig, ax = plt.subplots()
# Q = quiver(Y1, Y2, u, v, color="r")

title("Phase portrait in Julia.")
xlabel(L"$x_1$")
ylabel(L"$x_2$")
xlim([-4, 8])
ylim([-4, 4])

function on_button_press(event)
   n = 300 #number of timepoints
   t_sim = range(0, stop=1, length=n)
   t_span = (0.0, 300.0)
   x, y = event.xdata, event.ydata
   u0 = [x, y]
   prob = ODEProblem(f, u0, t_span)
   sol = solve(prob)
   plt.plot(sol(t_sim, idxs=1), sol(t_sim, idxs=2), "k-", markersize=10) # path
   plt.plot(sol(t_sim, idxs=1)[1], sol(t_sim, idxs=2)[2], "*", markersize=10) # start
   plt.plot(sol(t_sim, idxs=1)[end-1], sol(t_sim, idxs=2)[end], "o", markersize=10) # end
   fig.canvas.draw()
end

fig.canvas.mpl_connect("button_press_event", on_button_press)
plt.show()
