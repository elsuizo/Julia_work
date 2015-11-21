#= -------------------------------------------------------------------------
# @file annotate_image.jl
#
# @date 11/12/15 12:30:04
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
import ImageView
z = ones(10,50);
y = 8; x = 2;
z[y,x] = 0
zimg = convert(Image, z)
imgc, img2 = ImageView.view(zimg,pixelspacing=[1,1]);
Tk.set_size(ImageView.toplevel(imgc), 200, 200)
idx4 = ImageView.annotate!(imgc, img2, ImageView.AnnotationLine(x+10, y, x+20, y-6, linewidth=2, color=RGB(0,1,0)))
ImageView.delete!(imgc, idx)

