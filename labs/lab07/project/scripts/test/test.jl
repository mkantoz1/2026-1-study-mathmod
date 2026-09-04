using DifferentialEquations
using Plots

println("\nМоделирование завершено успешно!")


t0 = 0.0
x0 = 5.0      # Начальное число знающих людей (N0)
N = 500.0     # Максимальное количество потенциальных клиентов
tspan = (0.0, 30.0)

k_func(t) = 0.055
p_func(t) = 0.0018

function advertising_model!(dx, x, p_param, t)
    dx[1] = (k_func(t) + p_func(t) * x[1]) * (N - x[1])
end

prob = ODEProblem(advertising_model!, [x0], tspan)
sol = solve(prob, saveat=0.1)

plot(sol, label="Знающие о салоне x(t)", xlabel="Время t", ylabel="Количество людей",
     title="Распространение рекламы о салоне красоты", lw=2, color=:blue)
hline!([N], label="Предел N = $N", linestyle=:dash, color=:red)

k_2a(t) = 0.1
p_2a(t) = 0.001
model1!(dx, x, p, t) = (dx[1] = (k_2a(t) + p_2a(t) * x[1]) * (N - x[1]))
sol1 = solve(ODEProblem(model1!, [x0], tspan), saveat=0.1)

k_2b(t) = 0.001
p_2b(t) = 0.01
model2!(dx, x, p, t) = (dx[1] = (k_2b(t) + p_2b(t) * x[1]) * (N - x[1]))
sol2 = solve(ODEProblem(model2!, [x0], tspan), saveat=0.1)

plot(sol1, label="α1 > α2 (Платная реклама)", lw=2, xlabel="Время t",
     ylabel="Количество людей", title="Сравнение эффективности рекламных кампаний")
plot!(sol2, label="α1 < α2 (Сарафанное радио)", lw=2, linestyle=:dash, color=:orange)

k_3(t) = 0.005 * t
p_3(t) = 0.002 * t
model_lin!(dx, x, p, t) = (dx[1] = (k_3(t) + p_3(t) * x[1]) * (N - x[1]))

sol_lin = solve(ODEProblem(model_lin!, [x0], tspan), saveat=0.1)

times = sol_lin.t
dx_dt = [(k_3(ti) + p_3(ti) * sol_lin(ti)[1]) * (N - sol_lin(ti)[1]) for ti in times]

max_idx = argmax(dx_dt)
t_max = times[max_idx]
println("Максимально быстрый рост наблюдается в момент времени t = $t_max")

plot(times, dx_dt, label="Скорость роста dx/dt", xlabel="Время t",
     ylabel="Скорость", title="Момент времени с максимально быстрым ростом", lw=2, color=:purple)
scatter!([t_max], [dx_dt[max_idx]], label="Максимум при t=$t_max", color=:red)


k_4(t) = 0.055
p_4(t) = 0.0
model_paid!(dx, x, p, t) = (dx[1] = (k_4(t) + p_4(t) * x[1]) * (N - x[1]))

sol_paid = solve(ODEProblem(model_paid!, [x0], tspan), saveat=0.1)

plot(sol_paid, label="Только платная реклама", xlabel="Время t", ylabel="Количество людей",
     title="Распространение информации только за счет платной рекламы", lw=2, color=:blue)


     x0_rumor = 5.0
k_5(t) = 0.0
p_5(t) = 0.0018
model_rumor!(dx, x, p, t) = (dx[1] = (k_5(t) + p_5(t) * x[1]) * (N - x[1]))

sol_rumor = solve(ODEProblem(model_rumor!, [x0_rumor], tspan), saveat=0.1)

plot(sol_paid, label="Только платная реклама", lw=2, xlabel="Время t",
     ylabel="Количество людей", title="Сравнение: платная реклама vs сарафанное радио")
plot!(sol_rumor, label="Только сарафанное радио", lw=2, linestyle=:dash, color=:red)
