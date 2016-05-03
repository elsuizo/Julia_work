//  FIXME(elsuizo:Esta mierda anda lenta es por que hay que vectorizar o algo asi)-->mar 03 may 2016 16:34:15 ART
# Cloud of point for image
using PyPlot
using Images
function cloud_of_points(img::AbstractArray)
    img = restrict(img)
    x, y = size(img)
    for j in 1:3:y
        for i in 1:3:x
            p = img[i,j]
            scatter3D(p.r, p.g, p.b, facecolors=[p.r, p.g, p.b])
        end
    end
end

