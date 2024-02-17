
#this file makes no sense because it spawns the in-game structures. If you want to do smt similar
#open a map editor, take notes of all the positions / sizes and then manually add the tiles / entities

function AND(inputs::Vector, outputs::Vector)
    error = 0

    if length(inputs) != 2
        wlerrors.WlConsole("weird bug, too many inputs!")
        return 6
    end
    input1 = inputs[1]
    input2 = inputs[2]

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
        if debug
            push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer+8), 24, 16, 16, 0, false, String(output.name))) #creates a 16x16 block with the output in (relative) 16x 24y
        end
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+16), 80, output.opposite, !output.opposite, String(output.name), true, 0)) #onlyenable / onlydisable, default is onlydisable true, opposite onlyenable true
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+16), 48, !output.opposite, output.opposite, String(output.name), true, 0)) #opposite of the prev one
    end

    #add the stuff that makes the instruction work

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
    if debug
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+8), 104, false, false, String(input1.name), true, 0))
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+24), 104, false, false, String(input2.name), true, 0))
    end

    wlmapbuilder.MapPointer += 48
    return error
end

function OR(inputs::Vector, outputs::Vector)
    error = 0

    #add the stuff that makes the instruction work
    if length(inputs) != 2
        wlerrors.WlConsole("weird bug, too many inputs!")
        return 6
    end
    input1 = inputs[1]
    input2 = inputs[2]

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
        if debug
            push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer+8), 24, 16, 16, 0, false, String(output.name))) #creates a 16x16 block with the output in (relative) 16x 24y
        end
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+16), 48, output.opposite, !output.opposite, String(output.name), true, 0)) #onlyenable / onlydisable, default is onlydisable true, opposite onlyenable true
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+16), 80, !output.opposite, output.opposite, String(output.name), true, 0)) #opposite of the prev one
    end

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
    if debug
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+8), 104, false, false, String(input1.name), true, 0))
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+24), 104, false, false, String(input2.name), true, 0))
    end
    wlmapbuilder.MapPointer += 48
    return error
end

function XOR(inputs::Vector, outputs::Vector)
    error = 0

    if length(inputs) != 2
        wlerrors.WlConsole("weird bug, too many inputs!")
        return 6
    end
    input1 = inputs[1]
    input2 = inputs[2]

    #create the tile structure
    wlmapbuilder.tiles, error = wlmapbuilder.ConcatenateStrings(wlmapbuilder.tiles, """
    3333333

     33333
     3   3
     3   3
     3   3
     3   3
     3   3
     3   3
     3   3
     3   3
     33333










    3333333""")
    if error != 0
        wlerrors.WlConsole("weird bug while concatenating strings")
        return error
    end

    for output in outputs
        if debug
            push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer+8), 24, 24, 16, 0, false, String(output.name)))
        end
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+20), 35, !output.opposite, output.opposite, String(output.name), true, 0)) #default is onlyenable true onlydisable false
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+20), 72, output.opposite, !output.opposite, String(output.name), true, 0)) #opposite    
    end
    
    push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer+24), 40, 16, 32, 0, input1.opposite, String(input1.name))) #default is false
    if (input1.opposite) #has to place the block in the opposite way, swapping the y
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+8), 72,(wlmapbuilder.MapPointer+8),56, 16, 16, 0, String(input1.name), true))
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+16), 56,(wlmapbuilder.MapPointer+16),72, 16, 16, 0, String(input1.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+8), 56,(wlmapbuilder.MapPointer+8),72, 16, 16, 0, String(input1.name), true))
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+16), 72,(wlmapbuilder.MapPointer+16),56, 16, 16, 0, String(input1.name), true))
    end

    push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer), 40, 16, 32, 0, input2.opposite, String(input2.name)))
    if (input2.opposite)
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+16), 72,(wlmapbuilder.MapPointer+16),56, 16, 16, 0, String(input2.name), true))
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+8), 56,(wlmapbuilder.MapPointer+8),72, 16, 16, 0, String(input2.name), true))
    else
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+16), 56,(wlmapbuilder.MapPointer+16),72, 16, 16, 0, String(input2.name), true))
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswapblock((wlmapbuilder.MapPointer+8), 72,(wlmapbuilder.MapPointer+8),56, 16, 16, 0, String(input2.name), true))
    end

    push!(wlmapbuilder.MapEntities, wlmapbuilder.Walkeline((wlmapbuilder.MapPointer+21), 56, "212121", false, false, false, false, false, false, true, true, false, "WalkelineIsDead")) #most of the bools are useless, except the idle one (last)

    if debug
        #extra: lets manually control the inputs
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+8), 104, false, false, String(input1.name), true, 0))
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+32), 104, false, false, String(input2.name), true, 0))
    end

    wlmapbuilder.MapPointer += 56
    return error
end

function IMPLIES(inputs::Vector, outputs::Vector)
    #A->B is the same as not A or B, let's invert the first input and call that function
    if length(inputs) != 2
        wlerrors.WlConsole("weird bug, too many inputs!")
        return 6
    end

    inputs[1].opposite = !inputs[1].opposite
    return OR(inputs, outputs)
end

function EQUIV(inputs::Vector, outputs::Vector)
    #A<->B is the same a A xnor B, let's invert the outputs and use xor
    for output in outputs
        output.opposite = !output.opposite
    end

    return XOR(inputs, outputs)
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

        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer), 24, 16, 64, 0, output.opposite, String(output.name)))

        wlmapbuilder.MapPointer += 32
    end
    
    return error
end

function CLOCK(outputs::Vector)
    error = 0
    #create the tile structure
    wlmapbuilder.tiles, error = wlmapbuilder.ConcatenateStrings(wlmapbuilder.tiles, """
    3333333333

     33333333
     3      3
     3      3
     3  33  3
     3      3
     3      3
     3      3
     3      3
     3  33333
     33333333










    3333333333""")
    if error != 0
        wlerrors.WlConsole("weird bug while concatenating strings")
        return error
    end

    for output in outputs
        if debug
            push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer+24), 48, 16, 16, 0, false, output.name))
        end
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+48), 72, true, false, String(output.name), true, 0))
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentflipswitch((wlmapbuilder.MapPointer+16), 32, false, true, String(output.name), true, 0))
    end

    push!(wlmapbuilder.MapEntities, wlmapbuilder.Walkeline((wlmapbuilder.MapPointer+32), 80, "212121", true, false, false, false, false, false, true, true, false, "WalkelineIsDead")) #most of the bools are useless, except the idle one (last)

    push!(wlmapbuilder.MapEntities, wlmapbuilder.Spring((wlmapbuilder.MapPointer+16), 48, true))
    push!(wlmapbuilder.MapEntities, wlmapbuilder.Spring((wlmapbuilder.MapPointer+16), 88, true))
    push!(wlmapbuilder.MapEntities, wlmapbuilder.JumpThru((wlmapbuilder.MapPointer+8), 40, 16, "wood", -1))
    

    wlmapbuilder.MapPointer += 80
    return error
end

function TRUE(outputs::Vector) 
    #the button is not a pressure plate, it has a state and a walkeline to trigger it
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

        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentpressureplate((wlmapbuilder.MapPointer+8), 48, 0, false, String(output.name), true, true, output.opposite))
        push!(wlmapbuilder.MapEntities, wlmapbuilder.Walkeline((wlmapbuilder.MapPointer+8), 40, "212121", true, false, false, false, false, false, true, true, true, "WalkelineIsDead")) #most of the bools are useless, except the idle one (last)


        wlmapbuilder.MapPointer += 32
    end
    
    return error
end

function FALSE(outputs::Vector)
    #FALSE sets the opposite to true, so let's invert the outputs and use the TRUE() function
    #it's not necessary but nice to have
    for output in outputs
        output.opposite = !output.opposite
    end

    return TRUE(outputs)
end

function PIXEL(outputs::Vector) #same as output but with 16x16 blocks in the same column
    error = 0
    ypointer = 24 #to spawn the blocks in the same column

    wlmapbuilder.tiles, error = wlmapbuilder.ConcatenateStrings(wlmapbuilder.tiles, """
    33





















    33""")

    for output in outputs
        if error != 0
            wlerrors.WlConsole("weird bug while concatenating strings")
            return error
        end

        if ypointer > 120 #moves to a new column
            ypointer = 24
            wlmapbuilder.tiles, error = wlmapbuilder.ConcatenateStrings(wlmapbuilder.tiles, """
            33





















            33""")
            wlmapbuilder.MapPointer += 16
        end

        push!(wlmapbuilder.MapEntities, wlmapbuilder.Monumentswitchblock((wlmapbuilder.MapPointer-8), ypointer, 16, 16, 0, output.opposite, String(output.name)))
        ypointer += 16 #moves the next block in a lower space

    end

    wlmapbuilder.MapPointer += 16 #2 tiles by default + how many columns in the loop
    return error
end