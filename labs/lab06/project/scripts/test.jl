using DifferentialEquations
using Plots

println("\nМоделирование завершено успешно!")


# Параметры и начальные условия
N = 5000.0
I0 = 150.0
R0 = 0.0
S0 = N - I0 - R0

a = 0.001  # коэффициент заболеваемости (alpha)
b = 0.05   # коэффициент выздоровления (beta)

u0 = [S0, I0, R0]
tspan = (0.0, 200.0)
p = (a, b)

# Система дифференциальных уравнений для случая (a)
function epidemic_case_a!(du, u, p, t)
    S, I, R = u
    alpha, beta = p
    du[1] = 0.0           # dS/dt
    du[2] = -beta * I     # dI/dt
    du[3] = beta * I      # dR/dt
end

prob_a = ODEProblem(epidemic_case_a!, u0, tspan, p)
sol_a = solve(prob_a, Tsit5(), saveat=0.5)

# Построение графиков
plot(sol_a.t, [u[1] for u in sol_a.u], label="S(t) - Восприимчивые", color=:blue, linewidth=2)
plot!(sol_a.t, [u[2] for u in sol_a.u], label="I(t) - Инфицированные", color=:green, linewidth=2)
plot!(sol_a.t, [u[3] for u in sol_a.u], label="R(t) - С иммунитетом", color=:red, linewidth=2)

xlabel!("Время (t)")
ylabel!("Количество людей")
title!("Динамика эпидемии: случай I(0) <= I* (Изоляция)")


# Система дифференциальных уравнений для случая (б)
function epidemic_case_b!(du, u, p, t)
    S, I, R = u
    alpha, beta = p
    du[1] = -alpha * S * I              # dS/dt
    du[2] = alpha * S * I - beta * I    # dI/dt
    du[3] = beta * I                    # dR/dt
end

prob_b = ODEProblem(epidemic_case_b!, u0, tspan, p)
sol_b = solve(prob_b, Tsit5(), saveat=0.5)

# Построение графиков
plot(sol_b.t, [u[1] for u in sol_b.u], label="S(t) - Восприимчивые", color=:blue, linewidth=2)
plot!(sol_b.t, [u[2] for u in sol_b.u], label="I(t) - Инфицированные", color=:green, linewidth=2)
plot!(sol_b.t, [u[3] for u in sol_b.u], label="R(t) - С иммунитетом", color=:red, linewidth=2)

xlabel!("Время (t)")
ylabel!("Количество людей")
title!("Динамика эпидемии: случай I(0) > I* (Распространение)")

















