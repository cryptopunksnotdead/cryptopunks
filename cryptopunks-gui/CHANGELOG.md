# Change Log

## 0.0.15

- Upgrade to glimmer-dsl-tk 0.0.49

## 0.0.14

- Fix PNG signature not found issue on Windows by writing images as binary files (`chunky_png-1.4.0/lib/chunky_png/datastream.rb:107:in verify_signature!': PNG signature not found, found "\\x89PNG\\r\\r\\n\\x1A" instead of "\\x89PNG\\r\\n\\x1A\\n"! (ChunkyPNG::SignatureMismatch)`)
- Fix regression issue with image index allowed out of bounds when changing to a collection with less images than current collection

## 0.0.13

- Support older Ruby versions down to 2.7.2 by fixing an issue with not having `#name` method on `Symbol`

## 0.0.12

- Upgrade to glimmer-dsl-tk 0.0.46
- File & Help Menus
- Update COLLECTIONS_YAML_URL to point to cryptopunksnotdead repository (recently moved there)
- Add 'Mirror', 'Flip', 'Led' and 'Sketch' details (e.g. spacing or line) to output file name (e.g. '...-mirror.png')
- Fix issue with allowing out of bounds image index when entering index that is equal to count of images in a collection (off by 1 error)
- Fix written file name for downloaded sprites (was excluding .png before)
- Fix issue with @punk_directory mistakenly referenced after being removed through refactoring

## 0.0.11

- Support configuring default collections through a web hosted yaml file at: https://raw.githubusercontent.com/cryptopunksnotdead/cryptopunks-gui/master/cryptopunks-collections.yml
- New Green Punks, Clown Punks, and Bubble Gum Punks collections

## 0.0.10

- Fix issue with cryptopunks GUI erroring when cancelling selection of a new output location (or getting blocked by OS for security reasons)

## 0.0.9

- Added Halloween special collections: Scream, Jack 'O' Lantern, Joker, and Frankenstein

## 0.0.8

- Added missing Bored Apes (vanilla) collection
- Fixed Bored Apes collection image dimensions (28x28 instead of default 24x24)

## 0.0.7

- Multiple Punk Collections (https://github.com/cryptopunksnotdead/awesome-24px)

## 0.0.6

- Provide option to change output location
- Update default output location not to be a hidden location, switching `~/.cryptopunks` to `~/cryptopunks`
- Remember last selected output location upon app start
- Avoid hardcoding punk count in code (change 9999 to size of `@punks` array)

## 0.0.5

- Led style spacing option
- Led style round corner option
- Sketch style line option
- Apply zoom to led and sketch styles correctly
- Fixed issue with typing punk index higher than 9999 (ignore)

## 0.0.4

- Changed flip and mirror to checkbuttons
- Fixed zooming for led and sketch styles

## 0.0.3

- Style support (e.g. mirror, flip, sketch, led)

## 0.0.2

- Palette support (e.g. grayscale or sepia)

## 0.0.1

- Initial CryptoPunks GUI with support for punk index and zoom
