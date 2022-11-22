#import Pkg
#Pkg.add("JuMP")
#Pkg.add("Ipopt")

using JuMP
using Ipopt

N=3
N_sim = 20
alpha=1e-5

function StepModel(x, u)
    x1_plus = 2*x[1] + 1*x[2] + 1*u[1]
    x2_plus = 0*x[1] + 2*x[2] + 1*u[2]
    return [x1_plus, x2_plus]
end

function OptimalControl(x0)
    m=Model(Ipopt.Optimizer)
    @variable(m, x[i in 1:2, t in 0:(N)])
    @variable(m, u[i in 1:2, t in 0:(N-1)])    

    @constraint(m, [i in 1:2], x[i,0] == x0[i])
    #x1_plus = 2*x[1] + 1*x[2] + 1*u[1]
    @constraint(m, [t in 0:N-1], x[1, t+1] == 2*x[1,t] + 1*x[2,t] + 1*u[1,t])
    #x2_plus = 0*x[1] + 2*x[2] + 1*u[2]
    @constraint(m, [t in 0:N-1], x[2, t+1] == 0*x[1,t] + 2*x[2,t] + 1*u[2,t])

    @constraint(m, [t in 0:N-1], -5<= x[1, t] <=5 )
    @constraint(m, [t in 0:N-1, i in 1:2], -1<= u[i, t] <=1 )

    @constraint(m, -.1<= x[1,N] <=.1 )
    @constraint(m, -.1<= x[2,N] <=.1 )

    @objective(m, Min, 0.5*sum(alpha*x[i,t]^2 + u[i,t]^2 for t in 0:(N-1), i in 1:2))
    
    JuMP.optimize!(m)
    return [JuMP.value(u[1,0]),JuMP.value(u[2,0])]
end

x = zeros(Float64,2,N_sim+1)           
u = zeros(Float64,2,N_sim)  
x[:,1] = [0.5, 0.5]
for t = 1:N_sim
    u[:,t] = OptimalControl(x[:,t])
    x[:,t+1] = StepModel(x[:,t], u[:,t])
end
println(u)