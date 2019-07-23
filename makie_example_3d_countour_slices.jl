#= -------------------------------------------------------------------------
# @file makie_example_3d_countour_slices.jl
#
# @date 06/14/19 10:42:18
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
using AbstractPlotting
using LinearAlgebra

function test(x, y, z)
   xy = [x, y, z]
   ((xy') * Matrix(I, 3, 3) * xy) / 20
end
x = range(-2pi, stop = 2pi, length = 100)
scene = Scene()
# c[4] == fourth argument of the above plotting command
c = contour!(scene, x, x, x, test, levels = 6, alpha = 0.3, transparency = true)[end]
xm, ym, zm = minimum(scene.limits[])
contour!(scene, x, x, map(v-> v[1, :, :], c[4]), transformation = (:xy, zm), linewidth = 2)
heatmap!(scene, x, x, map(v-> v[:, 1, :], c[4]), transformation = (:xz, ym))
contour!(scene, x, x, map(v-> v[:, :, 1], c[4]), fillrange = true, transformation = (:yz, xm))
# reorder plots for transparency
scene.plots[:] = scene.plots[[1, 3, 4, 5, 2]]
scene

