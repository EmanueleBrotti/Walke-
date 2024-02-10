module wlerrors
export WriteError, Errorline, Errorfile, WlConsole

global ErrorLine::Int = 0 #to see where the error is
global ErrorFile::String = "" #the main will update all of this

WlLog::String = "Walke- By Brotti Emanuele"#log file

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

    WlConsole(errortext)
    return

end

function WlConsole(text::AbstractString)
    text = "- " * text #the line is here only to be quirky
    println(text)
    wlerrors.WlLog = WlLog * (text * "\n") 
    return
end

function WlSaveLog()
    path = "Programs/Outputs/WlLog.txt"
    open(path, "w") do f #saves the log in the path
        write(f, wlerrors.WlLog)
    end
end

end