#= -------------------------------------------------------------------------
# @file makie_example_differential_equation.jl
#
# @date 06/13/19 09:17:31
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
using DifferentialEquations, ParameterizedFunctions
import AbstractPlotting: textslider

lorenz = @ode_def Lorenz begin           # define the system
   dx = σ * (y - x)
   dy = x * (ρ - z) - y
   dz = x * y - β*z
end σ ρ β

u0 = [1.0,0.0,0.0]                       # initial conditions
tspan0 = (0.0,100.0)                      # initial timespan
p0 = [10.0,28.0,8/3]                      # initial parameters
prob = ODEProblem(lorenz, u0, tspan0, p0)  # define the problem

## setup sliders and plotting

"The order of magnitude to range between."
OME = 8

sσ, oσ = textslider(exp10.(-OME:0.001:OME), "σ", start = p0[1]);

sρ, oρ = textslider(exp10.(-OME:0.001:OME), "ρ", start = p0[2]);

sβ, oβ = textslider(exp10.(-OME:0.001:OME), "β", start = p0[3]);

st, ot = textslider(exp10.(-OME:0.001:OME), "tₘₐₓ", start = tspan0[end]);

sr, or = textslider(100:10000, "resolution", start = 2000);

trange = lift(ot, or) do tmax, resolution
   LinRange(0.0, tmax, resolution)
end

data = lift(oσ, oρ, oβ, trange) do σ, ρ, β, ts
   Point3f0.(
             solve(
                   remake(
                          prob;
                          p = [σ, ρ, β],
                          tspan = (ts[1], ts[end])
                         )
                  )(ts).u
   )  # change to fit the dimensionality - maybe even return 2 arrays, or a set of `Point2`s...
end
parent = Scene(resolution = (1000, 500))
three = lines(data, linewidth = 1, transparency = true, color = ("#fe4a49", 0.6))
meshscatter!(three, data, markersize = 0.1, color = :gray)
scene = vbox(hbox(sσ, sρ, sβ, st, sr), three, parent = parent)
RecordEvents(scene, "output")


