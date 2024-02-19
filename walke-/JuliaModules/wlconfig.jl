module wlconfig
    export optimized, stop
    optimized = false #if enabled, adds less entities (removes the outputs and inputs in each gate) but makes the code more difficult to read
    stop = false #if enabled, adds a pause button to each gate. The button uses the #FFFFFF color

    function resetconfig()
        optimized = false
        stop = false
    end

    
end