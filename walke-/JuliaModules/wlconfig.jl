module wlconfig
    export optimized, stop, changeconfig, resetconfig
    global optimized = false #if enabled, adds less entities (removes the outputs and inputs in each gate) but makes the code more difficult to read
    global stop = false #if enabled, adds a pause button to each gate. The button uses the #FFFFFF color

    ConfigArray = String[]

    function resetconfig()
        wlconfig.optimized = false
        wlconfig.stop = false
    end

    function changeconfig(flag)
        error = 0
        
        if !in(flag, ConfigArray) #flag is not a valid config flag
            error = 1
            Main.wlerrors.WriteError(error, flag)
            return error
        end

        if isdefined(Main, Symbol(flag)) #checks if flag is a valid instruction
            error = Main.eval(Symbol(flag))() #calls the function
        else
            error = 6 #problems executing the instruction
            Main.wlerrors.WriteError(error, String(flag))
        end

        return error
    end

    function startconfig() 
        ListOfFiles = readdir("ListOfConfigs", join=true)
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
                
                push!(ConfigArray, uppercase(line)) #adds line to instructionarray
            end
        end
    end
    startconfig()

end