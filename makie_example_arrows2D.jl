#= -------------------------------------------------------------------------
# @file makie_example_arrows2D.jl
#
# @date 04/10/19 11:50:36
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
using Makie
using ImageFiltering

x = range(-2, stop = 2, length = 21)
y = x
z = x .* exp.(-x .^ 2 .- (y') .^ 2)
scene = contour(x, y, z, levels = 10, linewidth = 3)
u, v = ImageFiltering.imgradients(z, KernelFactors.ando3)
arrows!(x, y, u, v, arrowsize = 0.05)

