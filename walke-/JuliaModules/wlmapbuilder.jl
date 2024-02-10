using Maple #to actually create the map


#define the entities used for Maple
@mapdef Entity "EmHelper/Walkeline" Walkeline(x::Integer, y::Integer, haircolor::String="212121", left::Bool=true, weak::Bool=false, dangerous::Bool=false, ally::Bool=true, bouncy::Bool=false, smart::Bool=false, mute::Bool=false, nobackpack::Bool=false, idle::Bool=false, deathflag::String="WalkelineIsDead")
@pardef Monumentswapblock(x1::Integer, y1::Integer, x2::Integer=x1+16, y2::Integer=y1, width::Integer=defaultBlockWidth, height::Integer=defaultBlockHeight, pattern::Integer=0, color::String="82d9ff", mute::Bool=false) = Entity("EmHelper/Monumentswapblock", x=x1, y=y1, nodes=Tuple{Int, Int}[(x2, y2)], width=width, height=height, pattern=pattern, color=color, mute=mute)
@mapdef Entity "EmHelper/Monumentswitchblock" Monumentswitchblock(x::Integer, y::Integer, width::Integer=Maple.defaultBlockWidth, height::Integer=Maple.defaultBlockHeight, pattern::Integer=0, active::Bool=false, color::String="82d9ff")
@mapdef Entity "EmHelper/Monumentpressureplate" Monumentpressureplate(x::Integer, y::Integer, pattern::Integer=0, onetime::Bool=false, color::String="82d9ff", mute::Bool=false, isButton::Bool=false, disable::Bool=false)
@mapdef Entity "EmHelper/Monumentflipswitch" Monumentflipswitch(x::Integer, y::Integer, onlyEnable::Bool=false, onlyDisable::Bool=false, color::String="82d9ff", mute::Bool=false, pattern::Integer=0)
####################################

MapEntities = Entity[Player(24, 176)] #array that contains the entities of the map, starts with the player
MapName = "walke-program"

tiles = """
333333333333333333333333333333333333333333333333
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
333333333333333333333333333333333333333333333333"""
#first part of the room tiles, left empty

MapPointer = 392 #position offset for the next structure, every instruction spawns a different ingame structure

function ConcatenateStrings(s1::AbstractString, s2::AbstractString) #the problem is that i can't sum 2 strings together, but i have to sum them line by line
    sarray1 = split(s1, "\n")
    sarray2 = split(s2, "\n")
    if length(sarray1) != length(sarray2) #the map might end up messed up
        return "", 5
    end


    ConcatenatedStrings = [line1 * line2 for (line1, line2) in zip(sarray1, sarray2)] #concatenats all lines, zip is just for safety

    return String(join(ConcatenatedStrings, "\n")), 0 #returns a string and error
end

function BuildMap(name::AbstractString) 
    MapName = name #to have different maps while compiling different files
    #closes the room
    closedtiles, error = ConcatenateStrings(tiles, """
        3
        3
        3
        3
        3
        3
        3
        3
        3
        3
        3
        3
        3
        3
        3
        3
        3
        3
        3
        3
        3
        3
        3""")
    #println(lvl_1_fg)
    if error != 0
        wlerrors.WriteError(error, "")
        return error
    end
    fgTiles = FgTiles(closedtiles) #turns string of tiles into celeste tiles

    @time map = Map( #creates the map
    MapName,
    Room[
        Room(
            name = MapName,

            fgTiles = fgTiles, #tiles

            position = (0, 0), #position of the room
            size = size(fgTiles),

            entities = MapEntities #entities
        )
    ])

    @time dMap = Dict(map) #assemble the map
    MapPath = "Programs/Outputs/" * (MapName * ".bin")
    @time encodeMap(dMap, MapPath)
    println("done")
end

function BuildInstruction(inputs::Array{ColorStruct, 1}, name::AbstractString, outputs::Array{ColorStruct, 1})
    error = 0
    if isdefined(Main, Symbol(name)) #checks if name is a valid instruction
        error = eval(Symbol(name))(inputs, outputs) #calls the function
    else
        error = 6 #problems executing the instruction
        wlerrors.WriteError(error, String(name))
    end
    return error
end

function BuildInstruction(name::AbstractString, outputs::Array{ColorStruct, 1})

    return 0
end