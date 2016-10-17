#= -------------------------------------------------------------------------
# @file effect_of_different_zeros_location.jl
#
# @date 10/17/16 16:01:00
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

# function generate a family of Transfer functions
H(c::Number) = tf([-1, c], (c/2)*[1,3,2])

vals = [-10, -.25, -.1, .1, .25, 10]
# generate a vector of Transfer functions
tfs = [H(c) for c in vals];

stepplot(tfs)
