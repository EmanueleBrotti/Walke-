import JSON
struct ColorStruct #each color has a name and a flag, if false it should use the opposite
    name::String
    opposite::Bool
end

include.(filter(contains(r".jl$"), readdir("JuliaModules/"; join=true))) #includes all modules
include.(filter(contains(r".jl$"), readdir("JuliaModules/WlInstructions/"; join=true))) #includes all instructions
using .wlerrors, .wlmapbuilder

error = 0 #0 = no errors, different values have different errors
CodeLine = 0 #to see where the error is

function main()

    wlerrors.WlConsole("Walke- By Brotti Emanuele") #adds stuff to the log
    wlerrors.WlConsole("-------------------------")
    wlerrors.WlConsole("opening .wlk- files in /Programs/")


    ListOfCodes = filter(contains(r".wlk-$"), readdir("Programs/", join=true)) #open all "wlk-" files
    for file in ListOfCodes
        wlerrors.WlConsole("-------------------------")
        wlerrors.ErrorFile = file
        wlerrors.WlConsole("reading file " * String(file))
        error = 0 #resets the variables
        CodeLine = 0

        code = open(file) do f #divide the file in lines
            readlines(f)
        end

        for cline in code #read each line of code
            wlerrors.ErrorLine = CodeLine #for the wlerrors module
            cline = split(cline, "-")[1] #remove comments
            if (isempty(cline) || (all(isspace, cline))) #check if line is empty or all spaces
                CodeLine = CodeLine + 1 #skip it
                continue
            end
            cline = uppercase(cline) #turn line into UPPERCASE
            cline = replace(cline, r"\s+" => " ") #turn multiple spaces into a single one

            if count(occursin("=", cline)) != 1 #check if there isnt exactly one "="
                error = 1 #not valid instruction
                WriteError(error, cline)
                break #stops checking this file
            end

            instructionside = split(cline, "=")[1] #instructions are composed of "stuff = output"
            outputside = split(cline, "=")[2] 
            outputside = replace(outputside, " "=>"") #remove spaces
            instructions = split(instructionside, " ") #array of instructions
            output = split(outputside, ",") #array of outputs
            #filter instructions and output to remove all empty strings
            instructions = filter(!isempty, instructions)
            output = filter(!isempty, output)


            if length(output) > 1 #walke- doesn't support multi outputs yet
                error = 69
                wlerrors.WriteError(error, output)
                break
            elseif length(output) == 0 #forgor the outputs
                error = 3 #wrong structure
                wlerrors.WriteError(error, cline)
                break
            end

            if length(instructions) == 0 #forgor the instructions
                error = 3 #wrong structure
                wlerrors.WriteError(error, cline)
                break
            end

            #turn instructions and output into strings (from substrings)
            instructions = String.(instructions)
            output = String.(output)

            error = checkstructure(Tuple(instructions), output) #check wlstructurecheck.jl for more info

            if error != 0 #i keep making pauses in the code to not fuck up the next instructions
                break
            end

            CodeLine = CodeLine + 1
        end

        if error == 0 #compiles the map
            FileName = split(file, "/")[end] #removes folders
            FileName = replace(FileName, ".wlk-" => "")
            wlerrors.WlConsole("compiling " * String(FileName) * ".bin")
            wlmapbuilder.BuildMap(FileName)
        else
            wlerrors.WlConsole("Couldn't compile the map, an error was found!")
        end 
    end
end

main() #calls main
wlerrors.WlConsole("Script ended, creating log!")
wlerrors.WlSaveLog() #saves the log