# Cryptopunks GUI
## Simplified Minting

This is a Graphical User Interface for the famous [Cryptopunks Ruby gem](https://github.com/cryptopunksnotdead/cryptopunks/tree/master/cryptopunks).

It automatically downloads `punks.png` from https://github.com/larvalabs/cryptopunks on first use.

Minted cryptopunks are stored at `~/.cryptopunks/`.

![Screenshot](/screenshots/cryptopunks-gui-screenshot.png)

## Prerequities

- [Tcl/Tk (ActiveTcl)](https://tkdocs.com/tutorial/install.html)
- [RVM](https://rvm.io/) (unless you are on Windows)
- [Ruby 3.0.2 compiled with RVM for Tk](https://rvm.io/integration/tk#tk) (unless you are on Windows for which Tcl/Tk instructions include installation of Ruby)

## Setup

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

## License

[MIT](LICENSE.txt)

Copyright (c) 2021 - Cryptopunks GUI by [Andy Maleh](https://github.com/AndyObtiva)

--

[<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 />](https://github.com/AndyObtiva/glimmer) Built with [Glimmer](https://github.com/AndyObtiva/glimmer) (Ruby Desktop Development GUI Library)
