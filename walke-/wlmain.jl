import JSON
include.(filter(contains(r".jl$"), readdir("JuliaModules/"; join=true))) #includes all modules

error = 0 #0 = no errors, different values have different errors
CodeLine = 0 #to see where the error is

function main()

    ListOfCodes = filter(contains(r".wlk-$"), readdir("Programs/", join=true)) #open all "wlk-" files
    for file in ListOfCodes
        error = 0 #resets the variables
        CodeLine = 0

        code = open(file) do f #divide the file in lines
            readlines(f)
        end

        for cline in code #read each line of code
            cline = split(cline, "-")[1] #remove comments
            if (isempty(cline) || (all(isspace, cline))) #check if line is empty or all spaces
                CodeLine = CodeLine + 1 #skip it
                continue
            end
            cline = uppercase(cline) #turn line into UPPERCASE
            cline = replace(cline, r"\s+" => " ") #turn multiple spaces into a single one

            if count(occursin("=", cline)) != 1 #check if there isnt exactly one "="
                error = 1 #not valid instruction
                break #stops checking this file
            end

            instructionside = split(cline, "=")[1] #instructions are composed of "stuff = output"
            outputside = split(cline, "=")[2] 
            instructions = split(instructionside, " ") #array of instructions
            output = split(outputside, " ") #array of outputs

            if length(output) > 1 #walke- doesn't support multi outputs yet
                error = 69
                break
            elseif length(output) == 0 #forgor the outputs
                error = 3 #wrong structure
                break
            end

            if length(instructions) == 0 #forgor the instructions
                error = 3 #wrong structure
                break
            end

            #error = checkstructure()
            error = checkstructure(Tuple(instructions), output) #check wlstructurecheck.jl for more info

            if error != 0 #i keep making pauses in the code to not fuck up the next instructions
                break
            end





            CodeLine = CodeLine + 1
        end

    end
end

main() #calls main