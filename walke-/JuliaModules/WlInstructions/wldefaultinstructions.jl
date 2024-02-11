
function AND(inputs::Vector, outputs::Vector)
    error = 0
    #create the tile structure
    wlmapbuilder.tiles, error = wlmapbuilder.ConcatenateStrings(wlmapbuilder.tiles, """
    333333

     3333
     3  3
     3  3
     3333
     3  3
     3  3
     3  3
     3  3
     3  3
     3333










    333333""")
    if error != 0
        wlerrors.WlConsole("weird bug while concatenating strings")
        return error
    end

    #add the outputs
    for output in outputs
        OutputName = output.name
        OutputIsOpposite = output.opposite #if true it should act in the opposite way

        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer+8), 24, 16, 16, 0, false, String(OutputName))) #creates a 16x16 block with the output in (relative) 16x 24y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+16), 80, OutputIsOpposite, !OutputIsOpposite, String(OutputName), true, 0)) #onlyenable / onlydisable, default is onlydisable true, opposite onlyenable true
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+16), 48, !OutputIsOpposite, OutputIsOpposite, String(OutputName), true, 0)) #opposite of the prev one
    end

    #add the stuff that makes the instruction work
    if length(inputs) != 2
        wlerrors.WlConsole("weird bug, too many inputs!")
        return 6
    end
    input1 = inputs[1]
    input2 = inputs[2]

    push!(wlmapbuilder.MapEntities, wlmapbuilder.Walkeline((wlmapbuilder.MapPointer+16), 64, "212121", true, false, false, false, false, false, true, true, true, "WalkelineIsDead")) #most of the bools are useless, except the idle one (last)

    if (input1.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+8), 72,(wlmapbuilder.MapPointer+8),64, 16, 16, 0, String(input1.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+8), 64,(wlmapbuilder.MapPointer+8),72, 16, 16, 0, String(input1.name), true))
    end

    if (input2.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+8), 72,(wlmapbuilder.MapPointer+8),64, 16, 16, 0, String(input2.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+8), 64,(wlmapbuilder.MapPointer+8),72, 16, 16, 0, String(input2.name), true))
    end

    #extra: lets manually control the inputs
    push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+8), 104, false, false, String(input1.name), true, 0))
    push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+24), 104, false, false, String(input2.name), true, 0))

    wlmapbuilder.MapPointer += 48
    return error
end

function OR(inputs::Vector, outputs::Vector)
    error = 0
    #create the tile structure
    wlmapbuilder.tiles, error = wlmapbuilder.ConcatenateStrings(wlmapbuilder.tiles, """
    333333

     3333
     3  3
     3  3
     3333
     3  3
     3  3
     3  3
     3  3
     3  3
     3333










    333333""")
    if error != 0
        wlerrors.WlConsole("weird bug while concatenating strings")
        return error
    end

    #add the outputs
    for output in outputs
        OutputName = output.name
        OutputIsOpposite = output.opposite #if true it should act in the opposite way

        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer+8), 24, 16, 16, 0, false, String(OutputName))) #creates a 16x16 block with the output in (relative) 16x 24y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+16), 48, OutputIsOpposite, !OutputIsOpposite, String(OutputName), true, 0)) #onlyenable / onlydisable, default is onlydisable true, opposite onlyenable true
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+16), 80, !OutputIsOpposite, OutputIsOpposite, String(OutputName), true, 0)) #opposite of the prev one
    end

    #add the stuff that makes the instruction work
    if length(inputs) != 2
        wlerrors.WlConsole("weird bug, too many inputs!")
        return 6
    end
    input1 = inputs[1]
    input2 = inputs[2]

    push!(wlmapbuilder.MapEntities, wlmapbuilder.Walkeline((wlmapbuilder.MapPointer+16), 64, "212121", true, false, false, false, false, false, true, true, true, "WalkelineIsDead")) #most of the bools are useless, except the idle one (last)

    if (input1.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+8), 64,(wlmapbuilder.MapPointer+8),80, 16, 16, 0, String(input1.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+8), 80,(wlmapbuilder.MapPointer+8),64, 16, 16, 0, String(input1.name), true))
    end

    if (input2.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+8), 64,(wlmapbuilder.MapPointer+8),80, 16, 16, 0, String(input2.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+8), 80,(wlmapbuilder.MapPointer+8),64, 16, 16, 0, String(input2.name), true))
    end

    #extra: lets manually control the inputs
    push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+8), 104, false, false, String(input1.name), true, 0))
    push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+24), 104, false, false, String(input2.name), true, 0))

    wlmapbuilder.MapPointer += 48
    return error
end

function XOR(inputs::Vector, outputs::Vector) #unfinished

    return 0
end

function IMPLIES(inputs::Vector, outputs::Vector) #unfinished

    return 0
end

function EQUIV(inputs::Vector, outputs::Vector) #unfinished

    return 0
end

function BUTTON(outputs::Vector)
    error = 0
    for output in outputs #adds the structure for every output

        wlmapbuilder.tiles, error = wlmapbuilder.ConcatenateStrings(wlmapbuilder.tiles, """
        3333

    
    
    
    
    
    
    
    
    
    









         33
        3333""")

        if error != 0
            wlerrors.WlConsole("weird bug while concatenating strings")
            return error
        end

        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentpressureplate((wlmapbuilder.MapPointer+8), 168, 0, false, String(output.name), true, false, false))
        
        wlmapbuilder.MapPointer += 32
    end
    
    return error
end

function SWITCH(outputs::Vector) 
    error = 0
    for output in outputs #adds the structure for every output

        wlmapbuilder.tiles, error = wlmapbuilder.ConcatenateStrings(wlmapbuilder.tiles, """
        3333

    
    
    
    
    
    
    
    
         33
         33










        3333""")

        if error != 0
            wlerrors.WlConsole("weird bug while concatenating strings")
            return error
        end

        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+8), 104, false, false, String(output.name), true, 0))
        wlmapbuilder.MapPointer += 32
    end
    
    return error
end

function OUTPUT(outputs::Vector) 
    error = 0
    for output in outputs #adds the structure for every output

        wlmapbuilder.tiles, error = wlmapbuilder.ConcatenateStrings(wlmapbuilder.tiles, """
        3333

    
    
    
    
    
    
    
    
    
    










        3333""")

        if error != 0
            wlerrors.WlConsole("weird bug while concatenating strings")
            return error
        end

        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer), 24, 16, 64, 0, output.opposite, String(output.name))) #creates a 16x16 block with the output in (relative) 16x 24y
        
        wlmapbuilder.MapPointer += 32
    end
    
    return error
end

function CLOCK(outputs::Vector) #unfinished

    return 0
end