# <img src="https://raw.githubusercontent.com/AndyObtiva/cryptopunks-gui/master/icons/cryptopunks-gui.png" height=85 /> CryptoPunks GUI 0.0.6
## Simplified Minting
[![Gem Version](https://badge.fury.io/rb/cryptopunks-gui.svg)](http://badge.fury.io/rb/cryptopunks-gui)

This is a Graphical User Interface for the famous [cryptopunks Ruby gem](https://github.com/cryptopunksnotdead/cryptopunks/tree/master/cryptopunks).

It automatically downloads `punks.png` from https://github.com/larvalabs/cryptopunks on first use.

Minted cryptopunks are stored at `~/.cryptopunks/`.

![Screenshot](/screenshots/cryptopunks-gui-screenshot.png)

## Prerequities

- [Tcl/Tk (ActiveTcl)](https://tkdocs.com/tutorial/install.html)
- [RVM](https://rvm.io/) (unless you are on Windows)
- [Ruby 3.0.2 compiled with RVM for Tk](https://rvm.io/integration/tk#tk) (unless you are on Windows for which Tcl/Tk instructions include installation of Ruby)

## Setup

You can use CryptoPunks GUI via gem or via cloning repository.

### Gem

Run:

```
gem install cryptopunks-gui -v0.0.6
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

### Punk Index

Change punk index to pick a different punk.

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
