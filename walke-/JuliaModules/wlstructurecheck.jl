#depending on the number of instructions, it calls a different checkstructure()
#julia sucks and you cant force an array size inside a function so im using tuples, as for outputs idc

struct ColorStruct #each color has a name and a flag, if false it should use the opposite
    name::String
    opposite::Bool
end

#i wrote 2 functions that are basically a carbon copy of each other, but this system lets other people create their own
#functions with specific use cases!
function checkstructure(instructions::NTuple{3, String}, outputs::Array{String, 1}) #3 elements in the instruction + outputs
    error = 0
    InputsArray = ColorStruct[] #array of inputs, contains all valid colors + negated or not
    OutputsArray = ColorStruct[] #array of outputs, contains all valid colors + negated or not
    flaginstruction = 1 #if it's not set to 0, then no valid instruction name. If it finds an instruction after being set to 0, then
    #the user wrote some weird stuff and gives an error
    InstructionName = "" #the instruction that will be called if everything is correct

    for token in instructions
        cflag, checknot = checkcolor(token) #is the token a color?
        if cflag != 0 #the token is not a color, is it an instruction name?
            if flaginstruction == 0 #wait, we already found a valid instruction name, so the user wrote some weird multi instruction shit
                error = 7 #multiple instructions in a line
                return error
            else 
                iflag, size = checkinstruction(token) #check if it's a valid instruction
                if iflag != 0 #it's not
                    error = iflag #invalid instruction or color
                    return error
                else #it is! Let's check if the size is correct (3 inputs)
                    if size == 3 #it's correct!
                        flaginstruction = 0
                        InstructionName = uppercase(token)
                    else
                        error = 3 #wrong structure!
                        return error
                    end
                end
            end
        else #the token is a color, add it to the array of inputs
            if(checknot) #remove the first character from the color
                token = strip(token, ['!','~'])
            end

            push!(InputsArray, (token, checknot)) #adds the color + the flag
        end
    end
    if flaginstruction == 1
        error = 3 #wrong structure, there isnt an instruction!
        return error
    end

    #check the outputs
    for output in outputs
        cflag, checknot = checkcolor(output) #is the output a color?
        if cflag != 0 #the output is not a color
            error = cflag #invalid color
            return error
        else #the output is a color
            if(checknot) #remove the first character from the color
                output = strip(output, ['!','~'])
            end

            push!(OutputsArray, (output, checknot)) #adds the color + the flag
        end
    end

    #if everything went smoothly we should have an array of inputs, an array of outputs and an instruction name
    
    error = BuildInstruction(InstructionName, InputsArray, OutputsArray)

    return error
end


#same but for the instruction only case, no inputs
function checkstructure(instructions::NTuple{1, String}, output::Array{String, 1}) #instruction + outputs
    error = 0
    token = instructions[1] #the instruction
    OutputsArray = ColorStruct[] #array of outputs, contains all valid colors + negated or not

    iflag, size = checkinstruction(token) #check if it's a valid instruction
    if iflag != 0 #it's not
        error = iflag #invalid instruction
        return error
    end
    token = uppercase(token) #walke- is not case sensitive

    #check the outputs
    for output in outputs
        cflag, checknot = checkcolor(output) #is the output a color?
        if cflag != 0 #the output is not a color
            error = cflag #invalid color
            return error
        else #the output is a color
            if(checknot) #remove the first character from the color
                output = strip(output, ['!','~'])
            end

            push!(OutputsArray, (output, checknot)) #adds the color + the flag
        end
    end
    
    error = BuildInstruction(token, OutputsArray) #we dont have inputs

    return error
end

function checkstructure(x,y) #default function for invalid size
    return 3 #error, wrong structure
end