#= -------------------------------------------------------------------------
# @file chromatics_coord.jl
#
# @date 07/01/15 16:21:14
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

using Images, Colors

function chromatics_coord(img::AbstractArray)

    x, y = size(img)
    a = zeros(img)
    for i in 1:x
        for j in 1:y
            r = img[i, j].r 
            g = img[i, j].g 
            b = img[i, j].b
            s = r + g + b
            a[i, j] = RGB(r / s, g / s, b / s)
        end
    end
    return a 
end

function white_patch(img::AbstractArray)
    x, y = size(img) 
    out = zeros(img)
    r_m = maximum(red(img))
    g_m = maximum(green(img))
    b_m = maximum(blue(img))
    
    for i in 1:x
        for j in 1:y
            r = img[i, j].r 
            g = img[i, j].g 
            b = img[i, j].b
            out[i, j] = RGB(r / r_m, g / g_m, b / b_m)
        end
    end
    return out
end

