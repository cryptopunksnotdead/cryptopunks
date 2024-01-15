The Do-It-Yourself (DIY) [Factory of Modern Originals (FoMO)](https://github.com/profilepic/originals) Presents

# Punks (Incl. Ye Olde Punks V1/V2 Anno 2017), Phunks, Philips, Marilyns, Marcs, Saudis/Sheiks, Men In Black, Hotties & More (Pixel Characters / Avatars)

Yes, you can! Generate your own 24×24 (or 32×32 or 12×12) punk (incl. Matt & John's® ye olde punks v1/v2 anno 2017 style), phunk, philip, marilyn, marc, saudi/sheik, man in black, hottie & more (pixel) avatar / character images (off chain) from text attributes (via built-in spritesheets); incl. 2x/4x/8x zoom for bigger sizes and more



* home  :: [github.com/cryptopunksnotdead/cryptopunks](https://github.com/cryptopunksnotdead/cryptopunks)
* bugs  :: [github.com/cryptopunksnotdead/cryptopunks/issues](https://github.com/cryptopunksnotdead/cryptopunks/issues)
* gem   :: [rubygems.org/gems/punks](https://rubygems.org/gems/punks)
* rdoc  :: [rubydoc.info/gems/punks](http://rubydoc.info/gems/punks)




##  Usage

Let's generate some super-rare never-before-seen
punk (pixel) avatars / characters...


### 24px

``` ruby
require 'punks'

punk = Punk::Image.generate( 'Alien', 'Cap Forward', 'Small Shades', 'Pipe' )
punk.save( "./alien.png" )
punk.zoom(4).save( "./alien@4x.png" )
```

resulting in:

![](i/alien.png)

4x:

![](i/alien@4x.png)


or try a batch:

``` ruby
specs = parse_data( <<TXT )
  Female 1
  Female 2
  Female 3
  Male 1
  Male 2
  Male 3
  Female 2, Blonde Bob, Green Eye Shadow, Hot Lipstick
  Male 1, Mohawk
  Female 3, Wild Hair, Hot Lipstick
  Male 1, Wild Hair, Nerd Glasses, Pipe
  Male 2, Goat, Earring, Wild Hair, Big Shades
  Female 2, Earring, Purple Eye Shadow, Half Shaved, Hot Lipstick

  Zombie
  Zombie, Crazy Hair, Earring
  Zombie, Bandana, Eye Patch, Earring
  Zombie, Knitted Cap
  Zombie, Top Hat, Nerd Glasses, Cigarette
  Zombie, Wild Hair, 3D Glasses, Smile
  Zombie, Headband, Goat
  Zombie, Cap Forward, Small Shades, Pipe
  Zombie, Beanie, Smile
  Zombie, Hoodie

  Ape
  Ape, Headband
  Ape, Cap Forward, Earring
  Ape, Knitted Cap
  Ape, Knitted Cap, Small Shades
  Ape, Top Hat, Small Shades
  Ape, Cowboy Hat, 3D Glasses
  Ape, Hoodie

  Alien
  Alien, Knitted Cap, Earring
  Alien, Knitted Cap, Earring, Medical Mask
  Alien, Headband
  Alien, Cap Forward, Small Shades, Pipe
TXT


specs.each_with_index do |attributes, i|
  punk = Punk::Image.generate( *attributes )
  punk.save( "./punk#{i}.png" )
  punk.zoom(4).save( "./punk#{i}@4x.png" )
end
```

resulting in:

![](i/punk0.png)
![](i/punk1.png)
![](i/punk2.png)
![](i/punk3.png)
![](i/punk4.png)
![](i/punk5.png)
![](i/punk6.png)
![](i/punk7.png)
![](i/punk8.png)
...

4x:

![](i/punk0@4x.png)
![](i/punk1@4x.png)
![](i/punk2@4x.png)
![](i/punk3@4x.png)
![](i/punk4@4x.png)
![](i/punk5@4x.png)
![](i/punk6@4x.png)
![](i/punk7@4x.png)
![](i/punk8@4x.png)
...



### 12px

``` ruby
punk = Punk12::Image.generate( 'Pink Female', 'Blonde Bob', 'Mole' )
punk.save( "./punk12_pink_female.png" )
punk.zoom(10).save( "./punk12_pink_female@10x.png" )

punk = Punk12::Image.generate( 'Alien Green', 'Hoodie' )
punk.save( "./punk12_alien_green.png" )
punk.zoom(10).save( "./punk12_alien_green@10x.png" )
```

resulting in:

![](i/punk12_pink_female@10x.png)
![](i/punk12_alien_green@10x.png)


and so on and so forth. 


## Questions? Comments?

Join us in the [Punk Art discord (chat server)]( https://discord.gg/FE3HeXNKRa). Yes you can.
Your questions and commetary welcome.


Or post them over at the [Help & Support](https://github.com/geraldb/help) page. Thanks.

