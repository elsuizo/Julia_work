#= -------------------------------------------------------------------------
# @file luxor_graphs_test.jl
#
# @date 10/12/18 09:43:30
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
# includes
using Luxor, Colors

# NOTE(elsuizo: comenzamos con el tutorial y luego hacemos algo nosotros)--->12 Oct 2018
@png begin
   radius = 80
   setdash("dot")
   sethue("red")
   A, B = [Point(x, 0) for x in [-radius, radius]]
   line(A, B, :stroke)
   circle(O, radius, :stroke) # para referirnos al origen podemos usar la letra O!!!
   # podemos ponerle etiquetas a los puntos
   label("A", :NW, A)
   label("B", :NE, B)
   label("origin", :N, O)
   circle.([A, O, B], 2, :fill) # con esto dibujamos los puntos ya que tienen un radio chico
   circle.([A, B], 2radius, :stroke)
   # lo que viene el codigo para hallar las intersecciones de los circulos
   # le pasamos la linea y luego la circunferencia
   nints, C, D = intersectionlinecircle(Point(0, -2radius), Point(0, 2radius), A, 2radius)

   if nints == 2
      sethue("blue")
      circle.([C, D], 2, :fill) # marcamos el punto
      label.(["C", "D"], :N, [C, D])
   end

   nints, C1, C2 = intersectionlinecircle(O, D, O, radius)

   if nints == 2
      circle.(C1, 3, :fill) # marcamos el punto
      label("C1", :N, C1)
   end
   # luego lo que buscamos son los puntos de interseccion entre las circunferencias grandes y dos lineas
   # imaginarias que pasan por los puntos A y B y por C1
   nints, I3, I4 = intersectionlinecircle(A, C1, A, 2radius)
   nints, I1, I2 = intersectionlinecircle(B, C1, B, 2radius)
   sethue("black")
   circle.([I1, I2, I3, I4], 2, :fill) # marcamos los puntos
   if distance(C1, I3) < distance(C1, I4)
      ip1 = I1
   else
      ip1 = I2
   end

   if distance(C1, I3) < distance(C1, I4)
      ip2 = I3
   else
      ip2 = I4
   end
   label("ip1", :N, ip1)
   label("ip2", :N, ip2)
   circle(C1, distance(C1, ip1), :stroke)

   setline(5)
   setdash("solid")

   # usamos la funcion arc2r para graficar arcos
   # luego con la accion :path es como que se genera un path que luego podemos usar
   arc2r(B, A, ip1, :path) # centrado en B y va desde A hasta ip1
   arc2r(C1, ip1, ip2, :path) # centrado en C1 y va desde ip1 hasta ip1
   arc2r(A, ip2, B, :path)
   arc2r(O, B, A, :path)

   strokepreserve()
   setopacity(0.8)
   sethue("ivory")
   fillpath()
end
