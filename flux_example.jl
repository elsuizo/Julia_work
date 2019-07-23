#= -------------------------------------------------------------------------
# @file flux_example.jl
#
# @date 07/18/19 09:29:55
# @author Martin Noblia
# @email mnoblia@disroot.org
#
# @brief
# Este ejemplo lo saque del foro de Julia: https://discourse.julialang.org/t/diffeqflux-with-time-as-additional-input-to-neural-ode/26456/3
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
# ---------------------------------------------------------------------------=#
using DifferentialEquations
using Flux, DiffEqFlux
using Plots

# The system I'm trying to solve
function msd_system(du, u, p, t)
    m, k, c = p  # Mass, spring, damper

    # Hacky time-dependent force
    if t > 1 && t < 2
        F = 3*9.81
    else
        F = 0.
    end

    g = 9.81
    du[1] = u[2]  # x = ẋ
    du[2] = (F-g*m - k*u[1] - c*u[2])/m
end


# Parameters --- normal ODE
m = 1.
k = 5.
c = 1.
p = [m, k ,c]

u0 = [1.0f0, 0.0f0]
tspan = (0.0f0, 4.0f0)
ts = range(0.0f0, 4.0f0, length=300)

prob = ODEProblem(msd_system, u0, tspan, p)
sol = solve(prob, Tsit5(), saveat=ts);  # This will act as our target

# -- ODE Neural Network --

# Model
model = Chain(
    Dense(3, 50, swish),
    Dense(50, 2)
)
ps_m = Flux.params(model)

# Custom Neural ODE
function dudt_(u, p, t)
    input = [u; t]
    Flux.Tracker.collect(model(input))
end

p = Float32[0.0]
p = param(p)  # Seems like `p` must be included in `diffeq_rd`, even if unused by Neural ODE?
_u0 = param(u0)
prob_n_ode = ODEProblem(dudt_, u0, tspan)
diffeq_rd(p, prob_n_ode, Tsit5())  # Test run

function predict_rd()
    Flux.Tracker.collect(diffeq_rd(p, prob_n_ode, Tsit5(), saveat=ts, u0=_u0))
end

loss_rd() = sum(abs2, sol .- predict_rd())
loss_rd()  # Test run

# Callback
cb = function()
    display(loss_rd())
end

data = Iterators.repeated((), 1000)
opt = ADAM()
cb()  # Test call
Flux.train!(loss_rd, ps_m, data, opt, cb=Flux.throttle(cb, 1))

