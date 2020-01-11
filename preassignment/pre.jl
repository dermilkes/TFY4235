import PyPlot
import Polynomials

function main()
    steps = 75                  # Number of steps per walk
    N = 100000                   # Number of walks

    # Generates N random walks of length step_max
    rand_walks = cumsum((rand([-1,1], steps, N)), dims=1)
    data = zeros(Int, floor(Int, steps/2))
    for j = 1:N
        i = 2
        found = false
        while (!found) & (i <= steps)
            if rand_walks[i, j] == 0
                data[floor(Int, i/2)] += 1
                found = true
            end
            i += 2
        end
    end
    ln_data = map(log, data)
    t = collect(1:floor(Int, steps/2))
    ln_t = map(log, t)

    coeff = Polynomials.coeffs(Polynomials.polyfit(ln_t, ln_data, 1))
    fit = map((x)->coeff[1] + coeff[2]*x, ln_t)

    PyPlot.plot(ln_t, ln_data, ln_t, fit)
    PyPlot.show()
end

@time main()

