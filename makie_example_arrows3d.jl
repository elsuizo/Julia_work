#= -------------------------------------------------------------------------
# @file makie_example_arrows3d.jl
#
# @date 04/08/19 10:49:53
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
using LinearAlgebra

function SphericalToCartesian(r::T, θ::T, ϕ::T) where T <: AbstractArray
   x = @.r * sin(θ) * cos(ϕ)
   y = @.r * sin(θ) * sin(ϕ)
   z = @.r * cos(θ)
   Point3f0.(x, y, z)
end

n = 100^2 #number of points to generate
r = ones(n);
θ = acos.(1 .- 2 .* rand(n))
φ = 2π * rand(n)
pts = SphericalToCartesian(r,θ,φ)
arrows(pts, (normalize.(pts) .* 0.1f0), arrowsize = 0.02, linecolor = :green, arrowcolor = :darkblue)


