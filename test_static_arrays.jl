#= -------------------------------------------------------------------------
# @file test_static_arrays.jl
#
# @date 06/19/19 10:58:40
# @author Martin Noblia
# @email mnoblia@disroot.org
#
# @brief
# algunos tests con static arrays
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
using StaticArrays
using LinearAlgebra
"""
Compute the rotation around the `x` axis(in cartesian coordinates)

Input:
-----

∠ : Angle(Number)

Output:
------

Rₓ : Rotation matrix of angle Input

example:
-------

`R = rotx(deg2rad(30)) # rotation around x 30 degrees`
 """
function rotx(∠::Number)
   Rₓ = @SMatrix [1.0   0.0       0.0;
                  0.0  cos(∠)   -sin(∠);
                  0.0  sin(∠)   cos(∠)]

   return Rₓ
end


"""
Compute the rotation around the `y` axis(in cartesian coordinates)

Input:
-----

∠ : Angle(Number)

Output:
------

R_y: Rotation matrix of angle Input

example:
-------
`R = roty(deg2rad(30)) # rotation around y 30 degrees`

 """
function roty(∠::Number)

    R_y = @SMatrix [cos(∠)  0.0  sin(∠);
                     0.0    1.0     0.0;
                  -sin(∠)   0.0  cos(∠)]

    return R_y
end


"""
Compute the rotation around the `z` axis(in cartesian coordinates)

Input:
-----

∠ : Angle(Number)

Output:
------

R_z: Rotation matrix of angle Input

example:
-------

`R = rotz(deg2rad(30)) # rotation around z 30 degrees`
"""
function rotz(∠::Number)

    R_z = @SMatrix [cos(∠)  -sin(∠) 0.0;
                    sin(∠)   cos(∠) 0.0;
                     0.0       0.0  1.0]

    return R_z
end

"""
Rotatation about x axis
"""
function trotx(∠::Number)
   return rot2trans(rotx(∠))
end

"""
Rotatation about y axis
"""
function troty(∠::Number)
   return rot2trans(roty(∠))
end

"""
Rotatation about z axis
"""
function trotz(∠::Number)
   return rot2trans(rotz(∠))
end

"""
Convert a 3x3 Rotation matrix to a 4x4 homogeneous transformation
"""
function rot2trans(R::Array{Float64, 2})
  x = @SVector [0 ,0, 0, 1]
  v = @SVector [0, 0, 1]
  R_aux = @SMatrix vcat(R, v')
  return @SMatrix hcat(R, x)
end


"""
Compute the rotation Matrix from Euler angles from the convention ZYZ

Inputs:
------
ϕ: first angle of euler(Number)
θ: second angle of euler(Number)
ψ: third angle of euler(Number)

Output:
------

R: Rotation matrix(3x3 Array{Float64, 2})
"""
function euler2rot(ϕ::Number, θ::Number, ψ::Number)

    return R = rotz(ϕ) * roty(θ) * rotz(ψ)
end


"""
Compute the rotation Matrix from Euler angles from the convention ZYZ

Input:
------
vec: Vector with the euler angles([ϕ, θ, ψ])

Output:
------

R: Rotation matrix(3x3 Array{Float64, 2})

"""
function euler2rot(vec::Array{Number,1})
   l = length(vec)
   if l != 3
      error("The length of the vector must be 3")
   end
   return R = rotz(vec[1]) * roty(vec[2]) * rotz(vec[3])
end


