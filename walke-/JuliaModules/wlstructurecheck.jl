#depending on the number of instructions, it calls a different checkstructure()
#julia sucks and you cant force an array size inside a function so im using tuples, as for outputs idc

#i wrote 2 functions that are basically a carbon copy of each other, but this system lets other people create their own
#functions with specific use cases!
function checkstructure(instructions::NTuple{3, AbstractString}, outputs::Array{String, 1}) #3 elements in the instruction + outputs
    
    error = 0
    InputsArray = ColorStruct[] #array of inputs, contains all valid colors + negated or not
    OutputsArray = ColorStruct[] #array of outputs, contains all valid colors + negated or not
    flaginstruction = 1 #if it's not set to 0, then no valid instruction name. If it finds an instruction after being set to 0, then
    #the user wrote some weird stuff and gives an error
    InstructionName = "" #the instruction that will be called if everything is correct

    for token in instructions
        cflag, checknot = checkcolor(token) #is the token a color?
        if cflag == false #the token is not a color, is it an instruction name?
            iflag, size = checkinstruction(token) #check if it's a valid instruction
            if iflag == false #it's not
                error = 68 #invalid instruction or color
                wlerrors.WriteError(error, token)
                return error
            else #it is! Let's check if the size is correct (3 inputs)
                if size == 3 #it's correct! But wait, is it the only instruction in the line?
                    if flaginstruction == 0 #wait, we already found a valid instruction, so the user wrote some weird multi instruction shit
                        error = 4 #multiple instructions in a line
                        wlerrors.WriteError(error, instructions)
                        return error
                    end
                    #it is! Let's set the flag
                    flaginstruction = 0
                    InstructionName = uppercase(token) #not case sensitive
                else
                    error = 3 #wrong structure!
                    wlerrors.WriteError(error, instructions)
                    return error
                end
            end

        else #the token is a color, add it to the array of inputs
            if(checknot) #remove the first character from the color
                token = strip(token, ['!','~'])
            end

            push!(InputsArray, ColorStruct(token, checknot)) #adds the color + the flag
        end
    end
    if flaginstruction == 1
        error = 3 #wrong structure, there isnt an instruction!
        wlerrors.WriteError(error, instructions)
        return error
    end

    #check the outputs
    for output in outputs
        cflag, checknot = checkcolor(output) #is the output a color?
        if cflag == false #the output is not a color
            error = 2 #invalid color
            wlerrors.WriteError(error, output)
            return error
        else #the output is a color
            if(checknot) #remove the first character from the color
                output = strip(output, ['!','~'])
            end

            push!(OutputsArray, ColorStruct(output, checknot)) #adds the color + the flag
        end
    end

    #if everything went smoothly we should have an array of inputs, an array of outputs and an instruction name
    
    error = wlmapbuilder.BuildInstruction(InputsArray, InstructionName, OutputsArray)

    return error
end


#same but for the instruction only case, no inputs
function checkstructure(instructions::NTuple{1, AbstractString}, outputs::Array{String, 1}) #instruction + outputs
    error = 0
    token = instructions[1] #the instruction
    OutputsArray = ColorStruct[] #array of outputs, contains all valid colors + negated or not

    iflag = checkinstruction(token)[1] #check if it's a valid instruction
    if iflag == false #it's not
        error = 1 #invalid instruction
        wlerrors.WriteError(error, token)
        return error
    end
    token = uppercase(token) #walke- is not case sensitive

    #check the outputs
    for output in outputs
        cflag, checknot = checkcolor(output) #is the output a color?
        if cflag == false #the output is not a color
            error = 2 #invalid color
            wlerrors.WriteError(error, output)
            return error
        else #the output is a color
            if(checknot) #remove the first character from the color
                output = strip(output, ['!','~'])
            end

            push!(OutputsArray, ColorStruct(output, checknot)) #adds the color + the flag
        end
    end
    
    error = wlmapbuilder.BuildInstruction(token, OutputsArray) #we dont have inputs

    return error
end

function checkstructure(x,y) #default function for invalid size
    wlerrors.WriteError(3, output) #invalid structure
    return 3
end