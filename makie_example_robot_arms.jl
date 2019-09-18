using Makie
using AbstractPlotting: Mesh, Scene, LineSegments, translate!, rotate!, vbox, hbox, qrotation, mesh!
using GeometryTypes: HyperRectangle, Vec3f0, Point3f0, Sphere
using StaticArrays: SVector
using AbstractPlotting: textslider
using Observables: on
 """
   example by @pbouffard from JuliaPlots/Makie.jl#307
   https://github.com/pbouffard/miniature-garbanzo/
 """
 function triad!(scene, len; translation = (0f0,0f0,0f0), show_axis = false)
     ret = linesegments!(
         scene, [
             Point3f0(0) => Point3f0(len, 0, 0),
             Point3f0(0) => Point3f0(0, len, 0),
             Point3f0(0) => Point3f0(0, 0, len)
         ],
         color = [:red, :green, :blue],
         linewidth = 3
     )[end]
     translate!(ret, translation)
     return ret
 end
 # Joint vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
 mutable struct Joint
     scene::Scene
     triad::LineSegments
     # link::Mesh
     angle::Float32
     axis::Vec3f0
     offset::Vec3f0
 end

 function Joint(s::Scene)
     newscene = Scene(s)
     triad = triad!(newscene, 1)
     Joint(newscene, triad, 0f0, (0, 1, 0), (0, 0, 0))
 end

 function Joint(
         j::Joint;
         offset::Point3f0 = (0, 0, 0), axis = (0, 1, 0), angle = 0.0
     )
     jnew = Joint(j.scene)
     translate!(jnew.scene, j.offset)
     linesegments!(
         jnew.scene, [Point3f0(0) => offset], linewidth = 4,
         color = :magenta
     )
     jnew.axis = axis
     jnew.offset = offset
     setangle!(jnew, angle)
     return jnew
 end

 function setangle!(j::Joint, angle::Real)
     j.angle = angle
     rotate!(j.scene, qrotation(j.axis, angle))
 end

 # Joint ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

 joints = Vector{Joint}()
 links = Float32[5, 5]
 s = Scene(center = false, show_axis = false)
 push!(joints, Joint(s))
 joints[1].axis = (0,0,1) # first joint is yaw
 joints[1].offset = (0, 0, 1)
 push!(joints, Joint(joints[end]; offset = Point3f0(3,0,0), axis = (0,1,0), angle = -pi/4)) # Pitch
 push!(joints, Joint(joints[end]; offset = Point3f0(3,0,0), axis = (0,1,0), angle = pi/2)) # Pitch
 push!(joints, Joint(joints[end]; offset = Point3f0(1,0,0), axis = (0,1,0), angle = -pi/4)) # Pitch
 push!(joints, Joint(joints[end]; offset = Point3f0(1,0,0), axis = (0,0,1))) # Yaw
 push!(joints, Joint(joints[end]; offset = Point3f0(0,0,0), axis = (1,0,0))) # Roll

 sliders = []
 vals = []
 for i = 1:length(joints)
     slider, val = textslider(
         -180.0:1.0:180.0,
         "Joint $(i)",
         start = rad2deg(joints[i].angle)
     )
     push!(sliders, slider)
     push!(vals, val)
     on(val) do x
         setangle!(joints[i], deg2rad(x))
     end
 end

 # Add sphere to end effector:
 mesh!(joints[end].scene, Sphere(Point3f0(0.5, 0, 0), 0.25f0), color = :cyan)
 update_cam!(s, Vec3f0(7.0, 4.0, 6.0), Vec3f0(6.0, 2.5, 4.5))
 parent = Scene(resolution = (1000, 500))
 vbox(hbox(sliders...), s, parent = parent)
 RecordEvents(parent, "output")
