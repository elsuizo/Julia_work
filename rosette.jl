#= -------------------------------------------------------------------------
# @file rosette.jl
#
# @date 11/12/15 11:42:45
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
using Images
using PyPlot
# Rosette in cartesian coordinates
#=------------------------------------------------------------------------------
                        Rosette Functions
------------------------------------------------------------------------------=#
x(t, ρ=100, f₁=100, f₂=200) = (ρ/2) * (cos(f₁*t) + cos(f₂*t))
y(t, ρ=100, f₁=100, f₂=200) = (ρ/2) * (sin(f₁*t) - sin(f₂*t))
#=------------------------------------------------------------------------------
                        Plots
------------------------------------------------------------------------------=#
t = linspace(0,4π, 200) # time samples = 200

plot(x(t), y(t))
