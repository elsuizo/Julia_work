#= -------------------------------------------------------------------------
# @file trajectoria_misil.jl
#
# @date 10/12/18 11:41:36
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
# includes
using Luxor, Colors

@png begin
   offset = 200
   A = Point(-offset, 0)
   B = Point(offset, 0)
   setdash("dot")
   sethue("red")
   line(A, B, :stroke)
   # ponemos nombre y dibujamos a A
   label("O", :N, A)
   sethue("black")
   circle(A, 3, :fill) # marcamos el punto
   # dibujamos las circunferencias
   radius = 50
   radius_circles = [x for x in radius:radius:5radius]
   circle.(A, radius_circles, :stroke)
   for θ in range(0, step=π/6, length = 12)
      aux = polar.(5radius, θ)
      println(θ)
      sethue("red")
      setdash("solid")
      line(A, aux, :stroke)
   end
end
