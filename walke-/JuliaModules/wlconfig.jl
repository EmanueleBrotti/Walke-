module wlconfig
    export optimized, stop
    global optimized = false #if enabled, adds less entities (removes the outputs and inputs in each gate) but makes the code more difficult to read
    global stop = false #if enabled, adds a pause button to each gate. The button uses the #FFFFFF color

    ConfigArray = String[]

    function resetconfig()
        Main.optimized = false
        Main.stop = false
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