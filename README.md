# Walke-
julia script that turns a set of instructions into a playable celeste map
## Requirements
- a modded version of the celeste client
- [EmHelper](https://gamebanana.com/mods/53716)
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


## Credits
- Aletris, for compressing the logic gates as much as possible
- the [Maple](https://github.com/CelestialCartographers/Maple) team, the rep that made all of this possible

## Hacking the gate
i tried to code Walke- to be as modular as possible. I'm not actively working on it, but in theory it should be possible to add more instructions, following those rules:
- every instruction has a name containing a single UPPERCASE word with no spaces
- every instruction has to have a "=" in it, at least 1 token (its name) and 1 output
- right now walke- supports instructions with 3 or 1 tokens, other types can be implemented
to implement a custom instruction:
- add a .txt file in the ListOfInstructions folder, add "NAME = SIZE" in it (check the default one for more infos)
- if SIZE is different than 3 or 1, add a new module in the JuliaModules folder, with a custom checkstructure function
[UPDATEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE]
