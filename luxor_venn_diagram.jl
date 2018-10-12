#= -------------------------------------------------------------------------
# @file luxor_venn_diagram.jl
#
# @date 09/27/18 12:38:23
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
using Luxor
Drawing(400, 400, "/tmp/venn_diagram.svg")
background("white")
O = Point(200, 200)
R = 80
A = 0.9*R
for (i, color) in enumerate(["red", "green", "blue"])
    α = ((i-1)*2/3+1/2)*π
    sethue(color)
    circle(O + Point(A*cos(α), A*sin(α)), R, :stroke)
end
finish()
preview()

