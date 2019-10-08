using Makie

N = 2 # number of colours in default palette
sc = Scene()

xs = 0:2        # data
ys = zeros(3)

for i in 1:N    # plot lines
   lines!(sc,
          xs, ys;
          color = AbstractPlotting.default_palettes.color[][i],
          limits = FRect((0, 0), (10, 10)),
          linewidth = 5
         ) # plot lines with colors
end

center!(sc)

# @substep

for (i, rot) in enumerate(LinRange(0, π/2, N))
   rotate!(sc.plots[i+1], rot)
   arc!(sc,
        Point2f0(0),
        (8 - i),
        pi/2,
        (pi/2-rot);
        color = sc.plots[i+1].color,
        linewidth = 5,
        linestyle = :dash
       )
end

center!(sc)
