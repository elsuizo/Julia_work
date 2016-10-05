#= -------------------------------------------------------------------------
# @file vectors_matplotlib2.jl
#
# @date 10/04/16 23:52:16
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

plt[:figure]()
ax = plt[:gca]()
# ax.arrow( x, y, dx, dy, **kwargs )
ax[:arrow](0,0,1,0, fc="k", ec="k", head_width=0.1, head_length=0.1 )
ax[:arrow](0,0,0,1, fc="k", ec="k", head_width=0.1, head_length=0.1 )

ax[:set_xlim]([-1,10])
ax[:set_ylim]([-1,10])
plt[:draw]()
plt[:show]()
