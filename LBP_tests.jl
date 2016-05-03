#= -------------------------------------------------------------------------
# @file LBP_tests.jl
#
# @date 12/01/15 22:11:01
# @author Martin Noblia
# @email martin.noblia@openmailbox.org
#
# @brief
# Local Binary Pattern tests
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

using Images, ImageView, Colors

path = "/home/elsuizo/images/flor.jpeg"
path2 = "/home/elsuizo/images/baboon.jpg"
img = load(path2)
img_gray = convert(Image{Gray}, img)
M, N = size(img_gray)
bin_p = [2^7, 2^6, 2^5, 2^4, 2^3, 2^2, 2^1, 2^0]
img_LBP = zeros(M,N)
for j in 2:N-1
    for i in 2:M-1
        p = img_gray[i, j]
        binary = p .> img_gray[i-1:i+1, j-1:j+1]
        img_LBP[i, j] = sum(deleteat!(binary[:], 5) .* bin_p) / 255 
    end
end
view(img_LBP')

