#= -------------------------------------------------------------------------
# @file script_labels_colored.jl
#
# @date 08/05/15 12:27:46
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
#---------------------------------------------------------------------------
# imports
#---------------------------------------------------------------------------
using Images, ImageView, Color
include("/home/elsuizo/Image_processing/Julia/image_processing.jl")
#---------------------------------------------------------------------------
# read images
path1 = "IACI/Image_Processing/Deteccion_de_objetos/Images/manos1.jpeg"
path2 = "IACI/Image_Processing/Deteccion_de_objetos/Images/manos2.jpeg"
path3 = "IACI/Image_Processing/Deteccion_de_objetos/Images/manos3.jpeg"
img1 = imread(path1)
img2 = imread(path2)
img3 = imread(path3)

# threshold the rgb image
c = RGB(117, 66, 38)/255
s = [113, 80, 70]/255
manos_bin = ImageProcessing.RGB_threshold(img1, c, s)
#manos_bin = dilate(manos_bin)
#manos_bin = erode(manos_bin) 
manos_label = label_components(manos_bin)
println(maximum(manos_label))
manos_colored = ImageProcessing.colored_labels(manos_label)
view(img1)
view(manos_bin')
view(manos_colored')

