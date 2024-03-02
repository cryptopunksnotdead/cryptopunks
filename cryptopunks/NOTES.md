# Notes

## Todos

- [x]  add Cryptopunks::Image.read !!! alternative to "low-level" Pixelart::Image.read

- [x]  fix require pixelart   use require 'pixelart/base' and
        than   include Pixelart!!!






---

## help output with gli


```
$ punk -h

NAME
    punk - punk (or cryptopunk) command line tool


SYNOPSIS
    punk [global options] command [command options] [arguments...]


VERSION
    2024.2.29



GLOBAL OPTIONS
    -d, --dir, -o, --out, --outdir=DIR - Output directory (default: .)
    -f, --file=FILE                    - All-in-one composite image (default:
                                         ./punks.png)
    --help                             - Show this message
    --offset=NUM                       - Start counting at offset (default: 0)
    --seed=NUM                         - Seed for random number generation /
                                         shuffle (default: 4142)
    --verbose                          - (Debug) Show debug messages
    --version                          - Display the program version
    -z, --zoom=ZOOM                    - Zoom factor x2, x4, x8, etc. (default:
                                         1)



COMMANDS
    f, flip          - Flip (vertically) all punk characters in all-in-one punk
                       series composite (./punks.png)
    g, gen, generate - Generate punk characters from text attributes (from
                       scratch / zero) via builtin punk spritesheet
    help             - Shows a list of commands or help for one command
    l, ls, list      - List all punk archetype and attribute names from builtin
                       punk spritesheet
    q, query         - Query (builtin off-chain) punk contract for punk text
                       attributes by IDs - use 0 to 9999
    s, shuffle       - Shuffle all punk characters (randomly) in all-in-one punk
                       series composite (./punks.png)
    t, tile          - Get punk characters via image tiles from all-in-one punk
                       series composite (./punks.png) - for IDs use 0 to 9999
```
