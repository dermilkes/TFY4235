import PyPlot
import Polynomials

#=
    TFY4235 – Pre-assignment
    A program that simulates random walks and calclutates the probability of
    returing to 0 as a function of time.
=#

#=
    Simulates 'N' random walks with maximal length steps and records when each
    returns to 0. Returns the distribution of how long it took to return.
=#
function memory(steps::Int, N::Int)
    prob = zeros(Int, steps)
    for i = 1:N
        sig = 0
        k = 1
        num = 0
        while sig == 0
            num += 2*rand() - 1
            sig = sign(num)
            k += 1
        end
        k = 1
        while k <= steps
            num += 2*rand() - 1
            # println(i, ", ", k, ": ", num, ", ", sign(num))
            # println(k, ", ", num)
            if sign(num) != sig
                prob[k] += 1
                break
            end
            k += 1
        end
    end
    return prob
end


# Plots the probability and finds the fitting curve. Assuming p(t) = t^(-k)
function dataout(steps::Int, prob::Array{Int, 1})
    ln_prob = map(log, prob)
    t = collect(1:steps)
    ln_t = map(log, t)

    # Finds the fitting curve to the data
    pol = Polynomials.polyfit(ln_t, ln_prob, 1)
    coeff = Polynomials.coeffs(Polynomials.polyfit(ln_t, ln_prob, 1))
    fit = map((x)->coeff[1] + coeff[2]*x, ln_t)

    # Plotting of result
    PyPlot.plot(ln_t, ln_prob, ln_t, fit)
    PyPlot.show()
    println(coeff[2])
end


function main()
    steps = 10000                 # Number of steps per walk
    N = 40000000                  # Number of walks

    #=
    # Generate random walks
    @time rand_walk = randwalk(steps, N)
    # Find when walk returns to zero
    @time prob = prob_return(steps, N, rand_walk)
    =#

    @time prob = memory(steps, N)
    # Find fitting curve and present data
    @time dataout(steps, prob)
end

@time main()
