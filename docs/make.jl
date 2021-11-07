using MinionsREPL
using Documenter

DocMeta.setdocmeta!(MinionsREPL, :DocTestSetup, :(using MinionsREPL); recursive=true)

makedocs(;
    modules=[MinionsREPL],
    authors="Roger-luo <rogerluo.rl18@gmail.com> and contributors",
    repo="https://github.com/Roger-luo/MinionsREPL.jl/blob/{commit}{path}#{line}",
    sitename="MinionsREPL.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Roger-luo.github.io/MinionsREPL.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Roger-luo/MinionsREPL.jl",
)
