
import JSON
include.(filter(contains(r".jl$"), readdir("JuliaModules/"; join=true))) #includes all modules

error = 0 #0 = no errors, different values have different errors
CodeLine = 0 #to see where the error is







function main()
    println("hello")
end

main() #calls main