
include("../Maple/src/Maple.jl")
using .Maple

#define the entities used for Maple
@mapdef Entity "EmHelper/Walkeline" Walkeline(x::Integer, y::Integer, haircolor::String="212121", left::Bool=true, weak::Bool=false, dangerous::Bool=false, ally::Bool=true, bouncy::Bool=false, smart::Bool=false, mute::Bool=false, nobackpack::Bool=false, idle::Bool=false, deathflag::String="WalkelineIsDead")
@pardef Monumentswapblock(x1::Integer, y1::Integer, x2::Integer=x1+16, y2::Integer=y1, width::Integer=defaultBlockWidth, height::Integer=defaultBlockHeight, pattern::Integer=0, color::String="82d9ff", mute::Bool=false) = Entity("EmHelper/Monumentswapblock", x=x1, y=y1, nodes=Tuple{Int, Int}[(x2, y2)], width=width, height=height, pattern=pattern, color=color, mute=mute)
@mapdef Entity "EmHelper/Monumentswitchblock" Monumentswitchblock(x::Integer, y::Integer, width::Integer=Maple.defaultBlockWidth, height::Integer=Maple.defaultBlockHeight, pattern::Integer=0, active::Bool=false, color::String="82d9ff")
@mapdef Entity "EmHelper/Monumentpressureplate" Monumentpressureplate(x::Integer, y::Integer, pattern::Integer=0, onetime::Bool=false, color::String="82d9ff", mute::Bool=false, isButton::Bool=false, disable::Bool=false)
@mapdef Entity "EmHelper/Monumentflipswitch" Monumentflipswitch(x::Integer, y::Integer, onlyEnable::Bool=false, onlyDisable::Bool=false, color::String="82d9ff", mute::Bool=false, pattern::Integer=0)
####################################

MapEntities = Entity[Player(24, 176)] #array that contains the entities of the map, starts with the player

lvl_1_fg = """
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


function BuildMap() 
    #closes the room
    lvl_1_fg = concstrings(lvl_1_fg, """
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
    fgTiles = FgTiles(lvl_1_fg) #turns string into tiles

    @time map = Map( #creates the map
    "Walke-Program",
    Room[
        Room(
            name = "lvl_1",

            fgTiles = fgTiles, #tiles

            position = (0, 0), #position of the room
            size = size(fgTiles),

            entities = MapEntities #entities
        )
    ])

    @time dMap = Dict(map) #assemble the map
    @time encodeMap(dMap, "WalkeProgram.bin")
end





