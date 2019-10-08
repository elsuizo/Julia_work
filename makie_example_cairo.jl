#= -------------------------------------------------------------------------
# @file makie_example_cairo.jl
#
# @date 09/21/19 22:43:19
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
using Makie, CairoMakie
tmp = "/tmp//test64.png"
png_backend = CairoMakie.CairoBackend(tmp)
scene5 = lines(1:10, rand(10))
lines!(scene5, 1:10, rand(10), color=:red)
ls5 = Makie.legend(scene5.plots[2:end], ["One", "Two"], camera=campixel!,raw=true)
fullscene = vbox(ls5, scene5)
AbstractPlotting.backend_display(png_backend, fullscene);

test64

