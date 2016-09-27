#= -------------------------------------------------------------------------
# @file vectors_matplotlib.jl
#
# @date 09/27/16 00:48:10
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

# Base canonica
X = (0,0)
Y = (0,0)
U = (0,1)
V = (1,0)

plt[:figure]()
ax = plt[:gca]()
ax[:quiver](X,Y,U,V,angles="xy",scale_units="xy",scale=1)
ax[:set_xlim]([-1,10])
ax[:set_ylim]([-1,10])
plt[:draw]()
plt[:show]()


