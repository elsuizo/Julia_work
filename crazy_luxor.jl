#= -------------------------------------------------------------------------
# @file crazy_luxor.jl
#
# @date 10/12/18 09:28:07
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
using Luxor, Colors
Drawing()
background("white")
origin()

@svg begin
    setline(0.5)
    poly([
        Point(e^(-k₁ * t) * (r * cos(k₃ * t + 1)) +
              e^(-k₂ * t) * (r * cos(k₄ * t + 1)),
              e^(-k₁ * t) * (r * sin(k₅ * t + 2)) +
              e^(-k₂ * t) * (r * sin(k₆ * t + 1)))
        for t in 0:0.05:500], :stroke)
end


