#= -------------------------------------------------------------------------
# @file makie_example_foro.jl
#
# @date 06/13/19 09:07:39
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
using AbstractPlotting
using Colors

x₀=-5.
gateState = false
xRange = 10

p₀(x) = x/2

nPts = 100.
x = (x₀ .+ collect((-nPts/2.):(nPts/2.))/nPts*xRange)
scene = lines(x, p₀(x),
    linewidth =4,
    color = :darkcyan,
    leg = false
)
axis = scene[Axis]
axis[:names][:axisnames] = ("x","y")

HC_handle = scatter!([-4], [2], marker=:circle, markersize = .5, color = :red)[end]

s1 = slider(LinRange(-5.0, 5.0, 101), raw = true, camera = campixel!, start = -5.0)

kx = s1[end][:value]

scatter!(
    scene, [kx; kx], lift(x-> [0.5; p₀(x)], kx), marker = :hexagon,
    color = RGBA(.5,0.,.5,.5),
    markersize = .35, strokewidth = 1, strokecolor = :black
)
Kc_handle = scene[end]
hbox(scene, s1, parent = Scene(resolution = (800, 600)))


