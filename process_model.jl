module process_model

export StepModel

function StepModel(x, u)
    x1_plus = 2*x[1] + 1*x[2] + 1*u[1]
    x2_plus = 0*x[1] + 2*x[2] + 1*u[2]
    return [x1_plus, x2_plus]
end

end