#= -------------------------------------------------------------------------
# @file phase_portrait_mouse_event.jl
#
# @date 06/19/16 18:08:27
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
#-------------------------------------------------------------------------
# imports
#-------------------------------------------------------------------------
using PyPlot
using PyCall
@pyimport scipy.integrate as integrate
@pyimport matplotlib as mpl
#-------------------------------------------------------------------------
# meshgrid from julia/examples
#-------------------------------------------------------------------------
ndgrid(v::AbstractVector) = copy(v)

function ndgrid{T}(v1::AbstractVector{T}, v2::AbstractVector{T})
    m, n = length(v1), length(v2)
    v1 = reshape(v1, m, 1)
    v2 = reshape(v2, 1, n)
    (repmat(v1, 1, n), repmat(v2, m, 1))
end

function ndgrid_fill(a, v, s, snext)
    for j = 1:length(a)
        a[j] = v[div(rem(j-1, snext), s)+1]
    end
end

function ndgrid{T}(vs::AbstractVector{T}...)
    n = length(vs)
    sz = map(length, vs)
    out = ntuple(n, i->Array(T, sz))
    s = 1
    for i=1:n
        a = out[i]::Array
        v = vs[i]
        snext = s*size(a,i)
        ndgrid_fill(a, v, s, snext)
        s = snext
    end
    out
end

meshgrid(v::AbstractVector) = meshgrid(v, v)

function meshgrid{T}(vx::AbstractVector{T}, vy::AbstractVector{T})
    m, n = length(vy), length(vx)
    vx = reshape(vx, 1, n)
    vy = reshape(vy, m, 1)
    (repmat(vx, m, 1), repmat(vy, 1, n))
end

function meshgrid{T}(vx::AbstractVector{T}, vy::AbstractVector{T},
                     vz::AbstractVector{T})
    m, n, o = length(vy), length(vx), length(vz)
    vx = reshape(vx, 1, n, 1)
    vy = reshape(vy, m, 1, 1)
    vz = reshape(vz, 1, 1, o)
    om = ones(Int, m)
    on = ones(Int, n)
    oo = ones(Int, o)
    (vx[om, :, oo], vy[:, on, oo], vz[om, on, :])
end


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

fig, ax = plt[:subplots]()
Q = quiver(Y1, Y2, u, v, color="r") 

title("Phase portrait in Julia.")
xlabel(L"$y_1$")
ylabel(L"$y_2$")
xlim([-2, 8])
ylim([-4, 4])
#

function on_button_press(event)

    t_sim = linspace(0, 50, 200)
    x, y = event[:xdata], event[:ydata]
    x₀ = [x, y]
    ys = integrate.odeint(f, x₀, t_sim)
    plt[:plot](ys[:,1], ys[:,2], "k-", markersize=10) # path
    plt[:plot]([ys[1,1]], [ys[1,2]], "o", markersize=10) # start
    plt[:plot]([ys[-2,1]], [ys[-2,2]], "s", markersize=10) # end
    
    fig[:canvas][:draw]()

end

fig[:canvas][:mpl_connect]("button_press_event", on_button_press)
plt[:show]()

