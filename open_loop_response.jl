#= -------------------------------------------------------------------------
# @file open_loop_response.jl
#
# @date 10/18/16 15:28:18
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
using ControlSystems
using PyPlot
numerator = 10
denominator = [5, 50, 1]
H = tf(numerator, denominator)
# initial condition
x₀ = [15, 0]
Δ = .1
t_f = 300
t = 0:Δ:t_f
y₁, t_out, x₁ = lsim(H,1.8*ones(t), t, x₀)
y₂, t_out, x₂ = lsim(H,2.0*ones(t), t, x₀)
y₃, t_out, x₃ = lsim(H,2.2*ones(t), t, x₀)

fig = figure(figsize=(10,10))
ax = gca()
plot(t, y₁, linestyle="-",linewidth=2,marker="None",label=L"(1.8)\,u(t)")
plot(t, y₂, linestyle="-",linewidth=2,marker="None",label=L"(2.0)\,u(t)")
plot(t, y₃, linestyle="-",linewidth=2,marker="None",label=L"(2.2)\,u(t)")
axis("tight")
title("Open loop simulations")
grid("on")
legend(loc="upper left",fancybox="true") 
savefig("/home/elsuizo/Images/open_loop.png")
