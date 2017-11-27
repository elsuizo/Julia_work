#= -------------------------------------------------------------------------
# @file pulse_train.jl
#
# @date 11/24/17 15:39:55
# @author Martin Noblia
# @email mnoblia@disroot.org
#
# @brief
# tests para generar un tren de pulsos
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
# TODO(elsuizo: reemplazar por implementacion pura en Julia)--->24 nov 2017
using PyCall
using PyPlot

@pyimport scipy.signal as signal
#= t = 0:0.01:1 =#
t = linspace(0, 3600, 1000000)
pulse_train = 1 + signal.square(2 * π * 1 * t, duty=1/10)
plot(t, pulse_train)

