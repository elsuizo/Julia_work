#= -------------------------------------------------------------------------
# @file open_cam_cv2.jl
#
# @date 06/29/15 22:55:30
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
using PyCall
@pyimport cv2

cv2.namedWindow("cam")
vc = cv2.VideoCapture(0)

if vc[:isOpened]()
    rval, frame = vc[:read]()
else
    rval = false
end


while rval
    cv2.imshow("cam", frame)
    rval, frame = vc[:read]()
    key = cv2.waitKey(7)
    if key == 27
        break
    end
end


