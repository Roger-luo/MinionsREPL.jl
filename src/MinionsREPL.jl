module MinionsREPL

function __init__()
    if ccall(:jl_generating_output, Cint, ()) == 0
        include(joinpath(@__DIR__, "repl.jl"))
    end
end

end
