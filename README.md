# <img src="https://raw.githubusercontent.com/AndyObtiva/cryptopunks-gui/master/icons/cryptopunks-gui.png" height=85 /> CryptoPunks GUI 0.0.9
## Simplified Minting
[![Gem Version](https://badge.fury.io/rb/cryptopunks-gui.svg)](http://badge.fury.io/rb/cryptopunks-gui)

This is a Graphical User Interface for the famous [cryptopunks Ruby gem](https://github.com/cryptopunksnotdead/cryptopunks/tree/master/cryptopunks).

It automatically downloads image collection sprites on first use (e.g. `punks.png` from https://github.com/larvalabs/cryptopunks).

Minted cryptopunks are stored at `~/cryptopunks/` by default ([output location can be changed](#output-location)).

![Screenshot](/screenshots/cryptopunks-gui-screenshot.png)

**Halloween 2021 Special Collections:**

Scream Punks

![Screenshot](/screenshots/cryptopunks-gui-screenshot-collection-scream-punks.png)

Jack 'O' Lantern Punks

![Screenshot](/screenshots/cryptopunks-gui-screenshot-collection-jack-o-lantern-punks.png)

Joker Punks

![Screenshot](/screenshots/cryptopunks-gui-screenshot-collection-joker-punks.png)

Frankenstein Punks

![Screenshot](/screenshots/cryptopunks-gui-screenshot-collection-frankenstein-punks.png)

## Prerequities

- [Tcl/Tk (ActiveTcl)](https://tkdocs.com/tutorial/install.html)
- [RVM](https://rvm.io/) (unless you are on Windows)
- [Ruby 3.0.2 compiled with RVM for Tk](https://rvm.io/integration/tk#tk) (unless you are on Windows for which Tcl/Tk instructions include installation of Ruby)

## Setup

You can use CryptoPunks GUI via gem or via cloning repository.

### Gem

Run:

```
gem install cryptopunks-gui -v0.0.9
```

Afterwards, run app via:

```
cryptopunks-gui
```

### Repository

Clone repository:

```
git clone https://github.com/AndyObtiva/cryptopunks-gui.git
```

Enter directory:

```
cd cryptopunks-gui
```

Run:

```
gem install bundler
bundle
```

Afterwards, run app via:

```
bin/cryptopunks-gui
```

Alternatively, run app manually via:

```
ruby app/cryptopunks_gui.rb
```

## Instructions

### Collection

Change collection to pick a different collection of images.

There are currently 38 available collections (from https://github.com/cryptopunksnotdead/awesome-24px):
- [Punks](https://raw.githubusercontent.com/larvalabs/cryptopunks/master/punks.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/punks-strip.png)
- [Mohawks](https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/mohawks.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/mohawks-strip.png)
- [Blondies](https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/blondies.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/blondies-strip.png)
- [Zombies](https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/zombies.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/zombies-strip.png)
- [Apes](https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/apes.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/apes-strip.png)
- [Aliens](https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/aliens.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/aliens-strip.png)
- [Golden Punks](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/goldenpunks.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/goldenpunks-strip.png)
- [Halloween Punks](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/halloweenpunks.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/halloweenpunks-strip.png)
- [Scream Punks](https://raw.githubusercontent.com/cryptopunksnotdead/cryptopunks/master/halloween/i/screampunks%402x.png)
- [Jack 'O' Lantern Punks](https://raw.githubusercontent.com/cryptopunksnotdead/cryptopunks/master/halloween/i/jackpunks%402x.png)
- [Joker Punks](https://raw.githubusercontent.com/cryptopunksnotdead/cryptopunks/master/halloween/i/jokerpunks%402x.png)
- [Frankenstein Punks](https://raw.githubusercontent.com/cryptopunksnotdead/cryptopunks/master/halloween/i/frankensteinpunks%402x.png)
- [Front Punks](https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/frontpunks.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/frontpunks-strip.png)
- [More Punks](https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/morepunks.png') ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/morepunks-strip.png)
- [Expansion Punks](https://expansionpunks.com/provenance/expansionpunks.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/expansionpunks-strip.png)
- [Avalanche Punks](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/avalanchepunks.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/avalanchepunks-strip.png)
- [International Punks](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/intlpunks.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/intlpunks-strip.png)
- [Ape Punks](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/apepunks.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/apepunks-strip.png)
- [Alien Clan](https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/alienclan.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/alienclan-strip.png)
- [Bored Apes](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/boredapes-strip.png)
- [Bored Apes Blue](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes_blue.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/boredapes_blue-strip.png)
- [Bored Apes Red](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes_red.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/boredapes_red-strip.png)
- [Bored Apes Neon Glow](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes_neon_glow.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/boredapes_neon_glow-strip.png)
- [Bored Apes Stars and Stripes](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes_stars_and_stripes.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/boredapes_stars_and_stripes-strip.png)
- [Bored Apes Acid](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes_acid.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/boredapes_acid-strip.png)
- [Cool Cats](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/coolcats-strip.png)
- [Cool Cats Mohawks](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_mohawks.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/coolcats_mohawks-strip.png)
- [Cool Cats Ninjas](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_ninjas.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/coolcats_ninjas-strip.png)
- [Cool Cats TV Heads](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_tvheads.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/coolcats_tvheads-strip.png)
- [Cool Cats Pirates](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_pirates.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/coolcats_pirates-strip.png)
- [Cool Cats Unicorns](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_unicorns.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/coolcats_unicorns-strip.png)
- [Cool Cats Dragons](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_dragons.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/coolcats_dragons-strip.png)
- [Cool Cats Frogs](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_frogs.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/blob/master/i/coolcats_frogs-strip.png)
- [Pudgy Penguins](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/pudgypenguins.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/pudgypenguins-strip.png)
- [Dodge](https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/dodge.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/dodge-strip.png)
- [Rocks](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/rocks.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/rocks-strip.png)
- [Punk Rocks](https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/punkrocks.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/punkrocks-strip.png)
- [Tulips](https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/tulips.png) ![image examples](https://github.com/cryptopunksnotdead/awesome-24px/raw/master/i/tulips-strip.png)

![Screenshot](/screenshots/cryptopunks-gui-screenshot-collection-zombies.png)

![Screenshot](/screenshots/cryptopunks-gui-screenshot-collection-apes.png)

![Screenshot](/screenshots/cryptopunks-gui-screenshot-collection-alien-clan.png)

![Screenshot](/screenshots/cryptopunks-gui-screenshot-collection-bored-apes-stars-and-stripes.png)

![Screenshot](/screenshots/cryptopunks-gui-screenshot-collection-cool-cats-ninjas.png)

![Screenshot](/screenshots/cryptopunks-gui-screenshot-collection-dodge.png)

### Image Index

Change image index to pick a different image.

![Screenshot](/screenshots/cryptopunks-gui-screenshot-different-punk-index.png)

### Zoom

Change zoom to enlarge punk to your liking.

![Screenshot](/screenshots/cryptopunks-gui-screenshot-different-zoom.png)

### Palette

Change palette to get different punk colors.

![Screenshot](/screenshots/cryptopunks-gui-screenshot-palette-standard.png)

![Screenshot](/screenshots/cryptopunks-gui-screenshot-palette-sepia.png)

![Screenshot](/screenshots/cryptopunks-gui-screenshot-palette-blue.png)

![Screenshot](/screenshots/cryptopunks-gui-screenshot-palette-false.png)

![Screenshot](/screenshots/cryptopunks-gui-screenshot-palette-grayscale.png)

### Style

Change style to get different punk looks.

#### Normal Style

![Screenshot](/screenshots/cryptopunks-gui-screenshot-style-normal.png)

#### Led Style

![Screenshot](/screenshots/cryptopunks-gui-screenshot-style-led.png)

##### Led Spacing

![Screenshot](/screenshots/cryptopunks-gui-screenshot-style-led-spacing.png)

##### Led Round Corner

![Screenshot](/screenshots/cryptopunks-gui-screenshot-style-led-round-corner.png)

#### Sketch Style

![Screenshot](/screenshots/cryptopunks-gui-screenshot-style-sketch.png)

##### Sketch Line

![Screenshot](/screenshots/cryptopunks-gui-screenshot-style-sketch-line.png)

### Mirror/Flip

Check mirror and/or flip to apply punk transformations. Can be combined with different palettes and styles.

![Screenshot](/screenshots/cryptopunks-gui-screenshot-no-mirror-no-flip.png)

![Screenshot](/screenshots/cryptopunks-gui-screenshot-mirror.png)

![Screenshot](/screenshots/cryptopunks-gui-screenshot-flip.png)

![Screenshot](/screenshots/cryptopunks-gui-screenshot-mirror-flip.png)

![Screenshot](/screenshots/cryptopunks-gui-screenshot-palette-false-style-led-mirror-flip.png)

### Output Location

You may select a new output location by clicking on the `...` button.

![Screenshot](/screenshots/cryptopunks-gui-screenshot-output-location.png)

## TODO

[TODO.md](TODO.md)

## Change Log

[CHANGELOG.md](CHANGELOG.md)

## Contributing
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## License

[MIT](LICENSE.txt)

Copyright (c) 2021 - Cryptopunks GUI by [Andy Maleh](https://github.com/AndyObtiva)

--

[<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 />](https://github.com/AndyObtiva/glimmer) Built with [Glimmer DSL for Tk](https://github.com/AndyObtiva/glimmer-dsl-tk) (MRI Ruby Desktop Development GUI Library)
