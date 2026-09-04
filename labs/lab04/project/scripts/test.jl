using DifferentialEquations
using Plots


println("\nМоделирование завершено успешно!")

using DifferentialEquations
using Plots

# Ortak parametreler ve başlangıç koşulları
w0 = 3.0             # Doğal frekans (ω0)
u0 = [2.0, 0.0]      # Başlangıç koşulları: x(0) = 2.0, x'(0) = 0.0
tspan = (0.0, 20.0)  # Zaman aralığı

# 1. Sönümsüz osilatör denklemi: x'' + w0^2 * x = 0
function osc_no_damping!(du, u, p, t)
    du[1] = u[2]
    du[2] = -w0^2 * u[1]
end

prob1 = ODEProblem(osc_no_damping!, u0, tspan)
sol1 = solve(prob1, saveat=0.05)

# Zaman - Konum grafiği
plot(sol1, vars=(0, 1), label="x(t)", xlabel="Время (t)", ylabel="Координата (x)", 
     title="1. Осциллятор без затухания", color=:blue, lw=2)


     # 2. Sönümlü osilatör denklemi: x'' + 2*gamma*x' + w0^2 * x = 0
gamma2 = 0.5  # Sönüm katsayısı (γ)

function osc_damping!(du, u, p, t)
    du[1] = u[2]
    du[2] = -2*gamma2 * u[2] - w0^2 * u[1]
end

prob2 = ODEProblem(osc_damping!, u0, tspan)
sol2 = solve(prob2, saveat=0.05)

# Zaman - Konum grafiği
p2_time = plot(sol2, vars=(0, 1), label="x(t)", xlabel="Время (t)", ylabel="Координата (x)", 
               title="2. Колебания с затуханием (x от t)", color=:red, lw=2)

# Faz Portresi (Hız x' - Konum x grafiği)
p2_phase = plot(sol2, vars=(1, 2), label="Фазовая траектория", xlabel="Координата (x)", ylabel="Скорость (x')", 
                title="Фазовый портрет (с затуханием)", color=:purple, lw=2)

# İki grafiği aynı anda göstermek için:
display(p2_time)
display(p2_phase)

# 3. Dış kuvvet etkisinde osilatör: x'' + 2*gamma*x' + w0^2 * x = f(t)
gamma3 = 0.5
f(t) = 2.0 * sin(1.5 * t)  # Dış kuvvet fonksiyonu f(t)

function osc_force!(du, u, p, t)
    du[1] = u[2]
    du[2] = -2*gamma3 * u[2] - w0^2 * u[1] + f(t)
end

prob3 = ODEProblem(osc_force!, u0, tspan)
sol3 = solve(prob3, saveat=0.05)

# Zaman - Konum grafiği
p3_time = plot(sol3, vars=(0, 1), label="x(t)", xlabel="Время (t)", ylabel="Координата (x)", 
               title="3. Колебания с внешней силой", color=:green, lw=2)

# Faz Portresi (Hız x' - Konum x grafiği)
p3_phase = plot(sol3, vars=(1, 2), label="Фазовая траектория", xlabel="Координата (x)", ylabel="Скорость (x')", 
                title="Фазовый портрет (с внешней силой)", color=:orange, lw=2)

# İki grafiği aynı anda göstermek için:
display(p3_time)
display(p3_phase)



