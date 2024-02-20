
#the legacy instructions have the benefit that they don't force the true / false state of the color
#the downside is that the same structure doesn't work for opposite outputs, so each one splits into two structures

function WOR(inputs::Vector, outputs::Vector)
    error = 0
    trueoutputs = [] #splits into two structures
    falseoutputs = [] #for the opposite
    #add the stuff that makes the instruction work
    if length(inputs) != 2
        wlerrors.WlConsole("weird bug, too many inputs!")
        return 6
    end
    
    for output in outputs
        if output.opposite
            push!(falseoutputs, output)
        else
            push!(trueoutputs, output)
        end
    end

    error = buildwor(inputs, trueoutputs)
    if error == 0
        error = buildwnor(inputs, falseoutputs)
    end
    return error
end

function buildwor(inputs::Vector, outputs::Vector) 
    error = 0
    if isempty(outputs) #all the outputs are in the opposite gate
        return 0
    end
    input1 = inputs[1]
    input2 = inputs[2]

    wlmapbuilder.tiles, error = wlmapbuilder.ConcatenateStrings(wlmapbuilder.tiles, """
        333333





















        333333""")

    for output in outputs
        if !wlconfig.optimized
            push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer), 80, 16, 16, 0, false, String(output.name))) #creates a 16x16 block with the output in (relative) 16x 24y
        end
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentpressureplate((wlmapbuilder.MapPointer+24), 64, 0, false, String(output.name), true, false, false))
        
    end

    push!(wlmapbuilder.MapEntities, wlmapbuilder.Walkeline((wlmapbuilder.MapPointer+24), 72, "212121", true, false, false, false, false, false, true, true, true, "WalkelineIsDead")) #most of the bools are useless, except the idle one (last)
    push!(wlmapbuilder.MapEntities, wlmapbuilder.JumpThru((wlmapbuilder.MapPointer+16), 64, 16, "wood", -1))

    if (input1.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+16), 72,(wlmapbuilder.MapPointer+16),80, 16, 16, 0, String(input1.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+16), 80,(wlmapbuilder.MapPointer+16),72, 16, 16, 0, String(input1.name), true))
    end

    if (input2.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+16), 72,(wlmapbuilder.MapPointer+16),80, 16, 16, 0, String(input2.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+16), 80,(wlmapbuilder.MapPointer+16),72, 16, 16, 0, String(input2.name), true))
    end

    if !wlconfig.optimized
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+8), 104, false, false, String(input1.name), true, 0))
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+24), 104, false, false, String(input2.name), true, 0))
    end

    wlmapbuilder.MapPointer += 48
    return error
end

function buildwnor(inputs::Vector, outputs::Vector)
    error = 0
    if isempty(outputs) #all the outputs are in the opposite gate
        return 0
    end
    input1 = inputs[1]
    input2 = inputs[2]
    wlmapbuilder.tiles, error = wlmapbuilder.ConcatenateStrings(wlmapbuilder.tiles, """
        333333





















        333333""")

    plateoffset = input2.opposite ? -16 : 0
    walkeoffset = input1.opposite ? 16 : 0
    for output in outputs
        if !wlconfig.optimized
            push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer+16), 80, 16, 16, 0, false, String(output.name))) #creates a 16x16 block with the output in (relative) 16x 24y
        end
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentpressureplate((wlmapbuilder.MapPointer+16), (62+plateoffset), 0, false, String(output.name), true, false, false))
    end
    
    push!(wlmapbuilder.MapEntities, wlmapbuilder.Walkeline((wlmapbuilder.MapPointer+8), (64+walkeoffset), "212121", true, false, false, false, false, false, true, true, true, "WalkelineIsDead")) #most of the bools are useless, except the idle one (last)

    if (input1.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer), 80,(wlmapbuilder.MapPointer),64, 16, 16, 0, String(input1.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer), 64,(wlmapbuilder.MapPointer),80, 16, 16, 0, String(input1.name), true))
    end

    if (input2.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+16), 46,(wlmapbuilder.MapPointer+16),62, 16, 16, 0, String(input2.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+16), 62,(wlmapbuilder.MapPointer+16),46, 16, 16, 0, String(input2.name), true))
    end

    if !wlconfig.optimized
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+8), 104, false, false, String(input1.name), true, 0))
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+24), 104, false, false, String(input2.name), true, 0))
    end

    wlmapbuilder.MapPointer += 48
    return error
end

function WAND(inputs::Vector, outputs::Vector) 
    error = 0
    trueoutputs = [] #splits into two structures
    falseoutputs = [] #for the opposite
    #add the stuff that makes the instruction work
    if length(inputs) != 2
        wlerrors.WlConsole("weird bug, too many inputs!")
        return 6
    end
    
    for output in outputs
        if output.opposite
            push!(falseoutputs, output)
        else
            push!(trueoutputs, output)
        end
    end

    error = buildwand(inputs, trueoutputs)
    if error == 0
        error = buildwnand(inputs, falseoutputs)
    end
    return error
end

function buildwand(inputs::Vector, outputs::Vector)
    error = 0
    if isempty(outputs) #all the outputs are in the opposite gate
        return 0
    end
    input1 = inputs[1]
    input2 = inputs[2]

    wlmapbuilder.tiles, error = wlmapbuilder.ConcatenateStrings(wlmapbuilder.tiles, """
        333333








           33












        333333""")

    for output in outputs
        if !wlconfig.optimized
            push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer+16), 80, 16, 16, 0, false, String(output.name))) #creates a 16x16 block with the output in (relative) 16x 24y
        end
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentpressureplate((wlmapbuilder.MapPointer+24), 72, 0, false, String(output.name), true, false, false))
        
    end

    push!(wlmapbuilder.MapEntities, wlmapbuilder.Walkeline((wlmapbuilder.MapPointer+16), 64, "212121", true, false, false, false, false, false, true, true, true, "WalkelineIsDead")) #most of the bools are useless, except the idle one (last)

    if (input1.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer), 72,(wlmapbuilder.MapPointer),64, 16, 16, 0, String(input1.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer), 64,(wlmapbuilder.MapPointer),72, 16, 16, 0, String(input1.name), true))
    end

    if (input2.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer), 72,(wlmapbuilder.MapPointer),64, 16, 16, 0, String(input2.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer), 64,(wlmapbuilder.MapPointer),72, 16, 16, 0, String(input2.name), true))
    end

    if !wlconfig.optimized
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+8), 104, false, false, String(input1.name), true, 0))
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+24), 104, false, false, String(input2.name), true, 0))
    end

    wlmapbuilder.MapPointer += 48
    return error
end

function buildwnand(inputs::Vector, outputs::Vector)
    error = 0
    if isempty(outputs) #all the outputs are in the opposite gate
        return 0
    end
    input1 = inputs[1]
    input2 = inputs[2]
    wlmapbuilder.tiles, error = wlmapbuilder.ConcatenateStrings(wlmapbuilder.tiles, """
        333333





















        333333""")

    for output in outputs
        if !wlconfig.optimized
            push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer+16), 72, 16, 16, 0, false, String(output.name))) #creates a 16x16 block with the output in (relative) 16x 24y
        end
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentpressureplate((wlmapbuilder.MapPointer+8), 62, 0, false, String(output.name), true, false, false))
    end
    
    push!(wlmapbuilder.MapEntities, wlmapbuilder.Walkeline((wlmapbuilder.MapPointer+8), 72, "212121", true, false, false, false, false, false, true, true, true, "WalkelineIsDead")) #most of the bools are useless, except the idle one (last)

    if (input1.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer), 80,(wlmapbuilder.MapPointer),72, 16, 16, 0, String(input1.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer), 72,(wlmapbuilder.MapPointer),80, 16, 16, 0, String(input1.name), true))
    end

    if (input2.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer), 80,(wlmapbuilder.MapPointer),72, 16, 16, 0, String(input2.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer), 72,(wlmapbuilder.MapPointer),80, 16, 16, 0, String(input2.name), true))
    end

    if !wlconfig.optimized
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+8), 104, false, false, String(input1.name), true, 0))
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+24), 104, false, false, String(input2.name), true, 0))
    end

    wlmapbuilder.MapPointer += 48
    return error
end

function WXOR(inputs::Vector, outputs::Vector)
    error = 0
    trueoutputs = [] #splits into two structures
    falseoutputs = [] #for the opposite
    #add the stuff that makes the instruction work
    if length(inputs) != 2
        wlerrors.WlConsole("weird bug, too many inputs!")
        return 6
    end
    
    for output in outputs
        if output.opposite
            push!(falseoutputs, output)
        else
            push!(trueoutputs, output)
        end
    end

    error = buildwxor(inputs, trueoutputs)
    if error == 0
        error = buildwxnor(inputs, falseoutputs)
    end
    return error
end

function buildwxor(inputs::Vector, outputs::Vector) 
    error = 0
    if isempty(outputs) #all the outputs are in the opposite gate
        return 0
    end
    input1 = inputs[1]
    input2 = inputs[2]
    wlmapbuilder.tiles, error = wlmapbuilder.ConcatenateStrings(wlmapbuilder.tiles, """
        333333





















        333333""")

    plateoffset = input2.opposite ? 24 : 0 #if opposite the block has y=78, not 62
    walkeoffset = input1.opposite ? -24 : 0
    for output in outputs
        if !wlconfig.optimized
            push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer+16), 32, 16, 16, 0, false, String(output.name))) #creates a 16x16 block with the output in (relative) 16x 24y
        end
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentpressureplate((wlmapbuilder.MapPointer+16), (54+plateoffset), 0, false, String(output.name), true, false, false))
    end
    
    push!(wlmapbuilder.MapEntities, wlmapbuilder.Walkeline((wlmapbuilder.MapPointer+8), (80+walkeoffset), "212121", true, false, false, false, false, false, true, true, true, "WalkelineIsDead")) #most of the bools are useless, except the idle one (last)

    if (input1.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer), 56,(wlmapbuilder.MapPointer),80, 16, 16, 0, String(input1.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer), 80,(wlmapbuilder.MapPointer),56, 16, 16, 0, String(input1.name), true))
    end

    if (input2.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+16), 78,(wlmapbuilder.MapPointer+16),54, 16, 16, 0, String(input2.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+16), 54,(wlmapbuilder.MapPointer+16),78, 16, 16, 0, String(input2.name), true))
    end

    if !wlconfig.optimized
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+8), 104, false, false, String(input1.name), true, 0))
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+24), 104, false, false, String(input2.name), true, 0))
    end

    wlmapbuilder.MapPointer += 48
    return error
end

function buildwxnor(inputs::Vector, outputs::Vector) 
    error = 0
    if isempty(outputs) #all the outputs are in the opposite gate
        return 0
    end
    input1 = inputs[1]
    input2 = inputs[2]
    wlmapbuilder.tiles, error = wlmapbuilder.ConcatenateStrings(wlmapbuilder.tiles, """
        333333





















        333333""")

    plateoffset = input2.opposite ? 24 : 0 #if opposite the block has y=78, not 62
    walkeoffset = input1.opposite ? 24 : 0
    for output in outputs
        if !wlconfig.optimized
            push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer+16), 32, 16, 16, 0, false, String(output.name))) #creates a 16x16 block with the output in (relative) 16x 24y
        end
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentpressureplate((wlmapbuilder.MapPointer+16), (54+plateoffset), 0, false, String(output.name), true, false, false))
    end
    
    push!(wlmapbuilder.MapEntities, wlmapbuilder.Walkeline((wlmapbuilder.MapPointer+8), (56+walkeoffset), "212121", true, false, false, false, false, false, true, true, true, "WalkelineIsDead")) #most of the bools are useless, except the idle one (last)

    if (input1.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer), 80,(wlmapbuilder.MapPointer),56, 16, 16, 0, String(input1.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer), 56,(wlmapbuilder.MapPointer),80, 16, 16, 0, String(input1.name), true))
    end

    if (input2.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+16), 78,(wlmapbuilder.MapPointer+16),54, 16, 16, 0, String(input2.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+16), 54,(wlmapbuilder.MapPointer+16),78, 16, 16, 0, String(input2.name), true))
    end

    if !wlconfig.optimized
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+8), 104, false, false, String(input1.name), true, 0))
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+24), 104, false, false, String(input2.name), true, 0))
    end

    wlmapbuilder.MapPointer += 48
    return error
end

function WEQUIV(inputs::Vector, outputs::Vector)
    #A<->B is the same a A xnor B, let's invert the outputs and use xor
    for output in outputs
        output.opposite = !output.opposite
    end

    return WXOR(inputs, outputs)
end

function WIMPLIES(inputs::Vector, outputs::Vector)
    #A->B is the same as not A or B, let's invert the first input and call that function
    if length(inputs) != 2
        wlerrors.WlConsole("weird bug, too many inputs!")
        return 6
    end

    inputs[1].opposite = !inputs[1].opposite
    return WOR(inputs, outputs)
end
