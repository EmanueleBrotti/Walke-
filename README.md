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
to prove that this language is turing complete.
This script compiles the code into a celeste map, that should be able to do simple logic operations.

## How does Walke- work?
- Walke- uses 6-digits hex codes (#FFFFFF) as bool variables (the only supported type!), each color can assume a "on/off" state in-game

  `for example, if #FF0000 is on, and #00FF00 is off, #FF0000 AND #00FF00 = #0000FF sets #0000FF off`
 
  ![#FF0000](https://placehold.co/15x15/ff0000/ff0000.png) and ![#00FF00](https://placehold.co/15x15/00ff00/00ff00.png) = ![#0000FF](https://placehold.co/15x15/0000ff/0000ff.png) 
- each instruction is always active, contrasting instructions create _weird bugs_
- the language is not CaSe SeNsItIvE
- walke- supports multiple outputs per instruction, separated by a `,`
- each line can only contain one instruction, or be left empty
- comments as always are ignored
- the map won't be compiled if the script encounters an error


## How to compile a Walke- script
- write your code in a text file, save it with the `.wlk-` extention (or check the examples in `Programs/Examples`)
- move the file in the `Programs` folder
- open the `walke-` folder in a code editor, run `wlmain.jl`
- please don't edit/delete the folders, checking the integrity of each path might be developed in the future

## Syntax
- comments start with `-`, everything after it will be ignored
- everything before `=` is part of the instruction, everything after is an output, that will store the results
- to use the opposite of a variable, add `!` or `~` before it. `for example, if #00000A is true, !#00000A is false`

the default instructions are:
- `#00000A AND #00000B = #00000C` - logical [and](https://en.wikipedia.org/wiki/Logical_conjunction) operator
- `#00000A OR #00000B = #00000C` - logical [or](https://en.wikipedia.org/wiki/Logical_disjunction) operator
- `#00000A XOR #00000B = #00000C` - logical [xor](https://en.wikipedia.org/wiki/Exclusive_or) operator
- `#00000A IMPLIES #00000B = #00000C` - logical [implication](https://en.wikipedia.org/wiki/Material_conditional)
- `#00000A EQUIV #00000B = #00000C` - [if and only if](https://en.wikipedia.org/wiki/If_and_only_if)
- `BUTTON = #00000C` - spawns an in-game button that changes state when pressed, reverts when not
- `SWITCH = #00000C` - spawns an in-game switch that changes state when touched
- `OUTPUT = #00000C` - spawns an in-game block, useful to see the value of a variable
- `CLOCK = #00000C`  - spawns an in-game clock that generates a periodic pulse
- `TRUE = #00000C`  - triggers the color when starting the room (it's like setting it "true")
- `FALSE = #00000C`  - just like TRUE, but sets true the opposite (it's a pseudoinstruction!)

## Credits
- Aletris, for compressing the logic gates as much as possible
- the [Maple](https://github.com/CelestialCartographers/Maple) team, the rep that made all of this possible

## Isn't it [Spass](https://webspass.spass-prover.org) but worse?
No, because Walke- can't detect contraddictions. If a contraddiction happens, then the code
behaves in an unpredictable way

## Hacking the gate
i tried to code Walke- to make it as modular as possible. I'm not actively working on it, but in theory it should be possible to add more instructions, following those rules:
- every instruction has a name containing a single UPPERCASE word with no spaces
- every instruction has to have exactly one `=` in it, at least 1 token (its name) and 1 output
- right now walke- supports instructions with 3 or 1 tokens, other types can be implemented

to implement a custom instruction:
- add a `.txt` file in the `ListOfInstructions` folder, write a new `"NAME = SIZE"` in it (check `default.txt ` more infos)
- if `SIZE` is different than 3 or 1, add a new module in `JuliaModules`, with a custom `checkstructure` function (open `wlstructurecheck,jl` to see how it works)
- create a `.jl` file in `JuliaModules/WlInstructions`, fill it with custom `NAME()` functions that `return 0` (no errors) or an integer (an error)
- your functions should accept an (optional) array of inputs and a (`NOT` optional) array of outputs. Each element is made from a custom struct (`ColorStruct`) that has an hex code (`.name`) and a value to check
  if you should generate the color or its opposite (`.opposite`)
- if you wish to create a different kind of in-game structure, you can code a custom `BuildInstruction`
