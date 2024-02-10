# Walke-
julia script that turns a set of instructions into a playable celeste map
## Requirements
- a modded version of the celeste client
- [EmHelper](https://gamebanana.com/mods/53716)
- [Julia](https://julialang.org) on your fav. code editor
- [Maple](https://github.com/CelestialCartographers/Maple)
- [JSON](https://juliapackages.com/p/json)
## What's Walke-
Walke- is an esoteric programming language made to simplify the process of "coding" in celeste,
using the entities in my helper. I wrote this script to eventually code Conway's game of life in the game,
to prove that it's turing complete.
This script compiles the code into a celeste map, that should be able to do simple logic operations.
## How does Walke- work?
- Walke- uses 6-digits hex codes as bool variables, each color in-game can assume a "on/off" state

  `for example, if #FF0000 is on, and #00FF00 is off, #FF0000 AND #00FF00 = #0000FF sets #0000FF off`
 
  ![#FF0000](https://placehold.co/15x15/ff0000/ff0000.png) and ![#00FF00](https://placehold.co/15x15/00ff00/00ff00.png) = ![#0000FF](https://placehold.co/15x15/0000ff/0000ff.png) 
- each instruction is always active, contrasting instructions create _weird bugs_
- the language is not CaSe SeNsItIvE
- right now Walke- supports only one output per instruction, this might change in the future
## How to compile a Walke- script
- write your code in a text file, save it with the ".wlk-" extention (or check the examples in the "Programs/Examples" folder)
- move the file in the "Programs" folder
- open the walke- folder in a code editor, run wlmain.jl
- please don't edit/delete the folders, checking the integrity of each path might be developed in the future
## Credits
- Aletris, for compressing the logic gates as much as possible
- the [Maple](https://github.com/CelestialCartographers/Maple) team, the rep that made all of this possible

## Hacking the gate
i tried to code Walke- to make it as modular as possible. I'm not actively working on it, but in theory it should be possible to add more instructions, following those rules:
- every instruction has a name containing a single UPPERCASE word with no spaces
- every instruction has to have a "=" in it, at least 1 token (its name) and 1 output
- right now walke- supports instructions with 3 or 1 tokens, other types can be implemented

to implement a custom instruction:
- add a .txt file in the ListOfInstructions folder, with "NAME = SIZE" in it (check the default one for more infos)
- if SIZE is different than 3 or 1, add a new module in the JuliaModules folder, with a custom checkstructure function (open wlstructurecheck to check how it works)
- create a .jl file in the JuliaModules/WlInstructions folder, fill it with custom NAME() functions that return 0 (no errors) or an integer (error)
- your functions should accept an (optional) array of inputs and a (NOT optional) array of outputs. The arrays use a custom struct (ColorStruct) that has an hex code (.name) and a value to check
  if you should generate the color or its opposite (.opposite)
- if you wish to create a different kind of in-game structure, you can code a custom BuildInstruction
