using DifferentialEquations
using Plots

println("\nМоделирование завершено успешно!")

a = 0.2
b = 0.5
c = 0.05
d = 0.02

u0 = [5.0, 10.0]     # [x(0) - хищники, y(0) - жертвы]
tspan = (0.0, 400.0) # Интервал времени t

function lotka_volterra!(du, u, p, t)
    x, y = u
    du[1] = -a * x + b * x * y
    du[2] = c * y - d * x * y
end

prob = ODEProblem(lotka_volterra!, u0, tspan)
sol = solve(prob, saveat=0.1)

p_time = plot(sol, label=["Хищники (x)" "Жертвы (y)"],
              xlabel="Время t", ylabel="Численность популяции",
              title="Динамика популяции хищников и жертв", lw=1.5)

p_phase = plot(sol, vars=(2, 1), label="Фазовая траектория",
               xlabel="Жертвы (y)", ylabel="Хищники (x)",
               title="Фазовый портрет (x от y)", color=:blue, lw=1.5)

plot(p_time, p_phase, layout=(1, 2), size=(1100, 500))
