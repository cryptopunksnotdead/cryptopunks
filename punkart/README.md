# punk art

punkart gem - (automagically) turn your "classic" punk (pixel) heads into dollar greenbacks, gold/silver/bronze coins, and much more



* home  :: [github.com/cryptopunksnotdead/cryptopunks](https://github.com/cryptopunksnotdead/cryptopunks)
* bugs  :: [github.com/cryptopunksnotdead/cryptopunks/issues](https://github.com/cryptopunksnotdead/cryptopunks/issues)
* gem   :: [rubygems.org/gems/punkart](https://rubygems.org/gems/punkart)
* rdoc  :: [rubydoc.info/gems/punkart](http://rubydoc.info/gems/punkart)




## Usage


### `Image#greenback` (also known as `dollar`, `dollarize`)



Let's print dollar greenbacks... brrr...

``` ruby
require 'punkart'

specs = [
  ['Robot Male', 'Big Beard'],
  ['Human Male 2', 'Birthday Hat', 'Bubble Gum'],
  ['Human Female 1', 'Dark Hair', 'Flowers', 'Frown', 'Gold Chain'],
  ['Demon Male',     'Hoodie', 'Pipe'],
  ['Ape Male Blue',  'Bandana', 'Earring'],
  ['Human Male 3',  'Cowboy Hat', 'Smile', 'Laser Eyes'],
]

specs.each_with_index do |attributes, i|
   punk = Punk::Image.generate( *attributes )

   dollar = punk.greenback  ## turn into greenback dollar
   dollar.save( "dollar-#{i+1}.png" )
   dollar.zoom(4).save( "dollar-#{i+1}@4x.png" )
end
```


Voila!

![](i/punk-1.png)
![](i/punk-2.png)
![](i/punk-3.png)
![](i/punk-4.png)
![](i/punk-5.png)
![](i/punk-6.png)

turns into

![](i/dollar-1.png)
![](i/dollar-2.png)
![](i/dollar-3.png)
![](i/dollar-4.png)
![](i/dollar-5.png)
![](i/dollar-6.png)

4x

![](i/dollar-1@4x.png)
![](i/dollar-2@4x.png)
![](i/dollar-3@4x.png)
![](i/dollar-4@4x.png)
![](i/dollar-5@4x.png)
![](i/dollar-6@4x.png)



### `Image#goldcoin` or `silvercoin` or `bronzecoin`

Let's continue and let's mint gold/silver/bronze coins...

``` ruby
specs.each_with_index do |attributes, i|
   punk = Punk::Image.generate( *attributes )

   coin = punk.goldcoin  ## turn into goldcoin
   coin.save( "goldcoin-#{i+1}.png" )
   coin.zoom(4).save( "goldcoin-#{i+1}@4x.png" )

   coin = punk.silvercoin  ## turn into silvercoin
   coin.save( "silvercoin-#{i+1}.png" )
   coin.zoom(4).save( "silvercoin-#{i+1}@4x.png" )

   coin = punk.bronzecoin  ## turn into bronzecoin
   coin.save( "bronzecoin-#{i+1}.png" )
   coin.zoom(4).save( "bronzecoin-#{i+1}@4x.png" )
end
```


Voila!

![](i/goldcoin-1.png)
![](i/goldcoin-2.png)
![](i/goldcoin-3.png)
![](i/goldcoin-4.png)
![](i/goldcoin-5.png)
![](i/goldcoin-6.png)

![](i/silvercoin-1.png)
![](i/silvercoin-2.png)
![](i/silvercoin-3.png)
![](i/silvercoin-4.png)
![](i/silvercoin-5.png)
![](i/silvercoin-6.png)

![](i/bronzecoin-1.png)
![](i/bronzecoin-2.png)
![](i/bronzecoin-3.png)
![](i/bronzecoin-4.png)
![](i/bronzecoin-5.png)
![](i/bronzecoin-6.png)


4x

![](i/goldcoin-1@4x.png)
![](i/goldcoin-2@4x.png)
![](i/goldcoin-3@4x.png)
![](i/goldcoin-4@4x.png)
![](i/goldcoin-5@4x.png)
![](i/goldcoin-6@4x.png)

![](i/silvercoin-1@4x.png)
![](i/silvercoin-2@4x.png)
![](i/silvercoin-3@4x.png)
![](i/silvercoin-4@4x.png)
![](i/silvercoin-5@4x.png)
![](i/silvercoin-6@4x.png)

![](i/bronzecoin-1@4x.png)
![](i/bronzecoin-2@4x.png)
![](i/bronzecoin-3@4x.png)
![](i/bronzecoin-4@4x.png)
![](i/bronzecoin-5@4x.png)
![](i/bronzecoin-6@4x.png)



That's it.


## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Post them over at the [Help & Support](https://github.com/geraldb/help) page. Thanks.


