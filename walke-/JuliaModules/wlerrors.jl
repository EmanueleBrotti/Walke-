module wlerrors
export WriteError, Errorline, Errorfile


global ErrorLine::Int = 0 #to see where the error is
global ErrorFile::String = "" #the main will update all of this


function WriteError(error::Int, element::Any)
    errortext = ("error " * string(error) * " on line " * string(ErrorLine) * " in file " * string(ErrorFile) * ": ")

    if error == 1 #Yanderedev moment
        errortext = errortext * (string(element) * " is not a valid instruction")
    elseif error == 2
        errortext = errortext * (string(element) * " is not a valid color")
    elseif error == 3
        errortext = errortext * (string(element) * " is not properly formatted!")
    elseif error == 4
        errortext = errortext * ("multiple instructions in a single line!")
    elseif error == 5
        errortext = errortext * ("problems compiling the map")
    elseif error == 6
        errortext = errortext * ("problem executing the instruction " * string(element))
    elseif error == 68
        errortext = errortext * (string(element) * " is not a valid color or instruction")
    elseif error == 69
        errortext = errortext * ("walke- doesn't support multi outputs yet")
    end

    println(errortext)
    return

end
end