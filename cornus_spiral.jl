#= -------------------------------------------------------------------------
# @file cornus_spiral.jl
#
# @date 03/23/16 12:20:07
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

f(x) = cos((π * x^2 )/2)
g(x) = sin((π * x^2 )/2)

x(t) = quadgk(f, 0, t)
y(t) = quadgk(g, 0, t)

X = [x(t)[1] for t in -7:.01:7]
Y = [y(t)[1] for t in -7:.01:7]

plot(X, Y)


