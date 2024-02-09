#checks if colors and instructions are correct

struct InstructionStruct #has a name and a size
    name::String
    size::Int
end

global InstructionArray = InstructionStruct[] #contains all valid instructions + sizes
    

function startInstructionArray() 
    #scan all text files in the ListOfInstructions folder
    ListOfFiles = readdir("ListOfInstructions", join=true)
    #open all files in a loop
    for file in ListOfFiles
        Lines = open(file) do f #read all lines
            readlines(f)
        end
        for line in Lines
            line = split(line, "-")[1] #remove comments
            line = replace(line, " "=>"") #remove spaces
            if (isempty(line)) #skips if empty
                continue
            end

            if count(occursin("=", line)) != 1 #check if there isnt exactly one "="
                #error, invalid instruction
                continue
            end

            size = split(line, "=")[2] #how many pieces the instruction requires
            line = split(line, "=")[1] #instruction
            instruction = InstructionStruct(line, parse(Int, size))

            push!(InstructionArray, instruction) #adds line to instructionarray

        end
    end

end
    
startInstructionArray() #starts the function

#match color string with regex to see if it's a valid 6 digit hex code
function checkcolor(color::String) #returns true if valid, false if not + checknot
    checknot = false; #starts the flag
    #check if color has 8 letters (not)
    if length(color) == 8
        #check if first character of the string is ! or ~ 
        if color[1] == '!' || color[1] == '~' #julia starts with 1 amazing
            checknot = true;
            color = strip(color, ['!','~']) #remove !~ from the string, already checked
        end
    end
    if length(color) == 7
        valid = occursin(r"^#([A-Fa-f0-9]{6})$", color) #matches the regex # + 6 hex digits
        return valid, checknot
    end
    return false, checknot #not a valid color + not is useless
end

#check if instruction is valid
function checkinstruction(instruction::String)
    #scan each element of the InstructionArray, if it's a valid instruction return true
    for element in InstructionArray
        if uppercase(instruction) == uppercase(element.name) #walke- is not case sensitive
            return true, element.size #returns true if valid and the required size, to match it with the touple
        end
    end
    return false, 0 #not a valid instruction + no size
end