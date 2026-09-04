using DifferentialEquations
using Plots

k=14.4

r1 = k/5.7
r2 = k/3.7
t1 = (0.0,2*pi)
t2=(-pi,pi)

fi = 3*pi/4
t = (0,50)

x(t)= tan(fi)*t

f(r,p,t) = r/sqrt(21.09)

prob = ODEProblem(f,r1,t1)

sol = solve(prob,saveat=0.01)

plot(sol.t,sol.u,proj=:polar, lims=(0,15),label="Движение катера")

angle = [fi for i in range(0,15)]
x_lim = [x(i) for i in range(0,15)]

plot(sol.t,sol.u,proj=:polar, lims=(0,15),label="Движение катера")
plot!(angle,x_lim,proj=:polar,lims=(0,15), label="Движение лодки")

y(x)=(14.40*exp(x))/sqrt(21.09)/(5.09)

y(fi)

prob2 = ODEProblem(f,r2,t2)

sol2 = solve(prob2,saveat=0.01)

plot(sol2.t,sol2.u,proj=:polar, lims=(0,15),label="Движение катера")
plot!(angle,x_lim,proj=:polar,lims=(0,15), label="Движение лодки")
