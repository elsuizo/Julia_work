#= -------------------------------------------------------------------------
# @file phase_portrait.jl
#
# @date 2015
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
include("/home/elsuizo/julia/examples/ndgrid.jl")


function f(Y,t)
    y1, y2 = Y
    return [y2, -sin(y1)]
end
 
y1 = linspace(-2.0, 8.0, 20);
y2 = linspace(-2.0, 2.0, 20);

Y1, Y2 = meshgrid(y1, y2)

t = 0
 

u, v = zeros(size(Y1)), zeros(size(Y2))

NI, NJ = size(Y1)

for i in 1:NI
    for j in 1:NJ
        x = Y1[i, j]
        y = Y2[i, j]
        y′ = f([x, y], t)
        u[i,j] = y′[1]
        v[i,j] = y′[2]
    end
end


Q = quiver(Y1, Y2, u, v, color="r") 

title("Phase portrait in Julia.")
xlabel(L"$y_1$")
ylabel(L"$y_2$")
xlim([-2, 8])
ylim([-4, 4])
#show()

