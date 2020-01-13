import PyPlot
import Polynomials

#=
    TFY4235 – Pre-assignment
    A program that simulates random walks and calclutates the probability of
    returing to 0 as a function of time.
=#


# Plots the probability and finds the fitting curve. Assuming p(t) = t^(-k)
function dataout(steps::Int, prob::Array{Int, 1})
    ln_prob = map(log, prob)
    t = collect(1:steps-1)
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


#=
    Generates 'N' random walks of length 'steps'. Each step has length between
    (-1, 1).
=#
function randwalk(steps::Int, N::Int)
    rand_num = map((x)->2*x - 1, rand(steps, N))
    return cumsum(rand_num, dims=1)
end


#=
    Takes a set of random walks and returns the distribution of when each return
    to zero
=#
function prob_return(steps::Int, N::Int, rand_walk::Array{Float64, 2})
    prob = zeros(Int, steps-1)
    for j = 1:N
        sig = 0
        for i = 1:steps
            if sig == 0
                sig = sign(rand_walk[i, j])
            elseif sign(rand_walk[i, j]) != sig
                prob[i-1] += 1
                break
            end
        end
    end
    return prob
end

function main()
    steps = 100                 # Number of steps per walk
    N = 400000                  # Number of walks

    # Generate random walks
    rand_walk = randwalk(steps, N)
    # Find when walk returns to zero
    prob = prob_return(steps, N, rand_walk)
    # Find fitting curve and present data
    dataout(steps, prob)
end

@time main()
