
# Starwars Expirement

The idea - use the Starwars API to get all 91 (?) characters (people)
data that incl. gender, hair_color, skin_color, eye_color
and species.

Use these data points to (try to) generate punks...

Stats:

Species  ???

Gender  ???

Hair Color ???

Skin Color ???

Eye Color ???


```
"classification": "mammal",
"name":           "Human",
"designation":    "sentient",
"eye_colors":     "brown, blue, green, hazel, grey, amber",
"skin_colors":    "caucasian, black, asian, hispanic",
"hair_colors":    "blonde, brown, black, red",
"people": [
            1, 4, 5, 6, 7, 9, 10, 11, 12,
            14, 18, 19, 21, 22, 25, 26, 28,
            29, 32, 34, 35, 39, 42, 43, 51,
            60, 61, 62, 66, 67, 68, 69, 74,
            81, 82
        ]
```

35 Humans:

```
{"gender" => {"male"=>26,
              "female"=>9},
 "skin_color" => {"fair"=>17,
                 "white"=>1,     # Darth Vader
                 "light"=>9,
                 "pale"=>2,
                 "dark"=>4,
                 "tan"=>2},
 "hair_color" => {"none"=>4,
                  "blond"=>3,
                  "brown"=>13,
                  "brown-grey"=>1,
                  "black"=>8,
                  "auburn"=>1,
                  "auburn-white"=>1,
                  "auburn-grey"=>1,
                  "grey"=>1,
                  "white"=>2},
 "eye_color" => {"blue"=>13,
                 "blue-gray"=>1,
                 "yellow"=>2,
                 "brown"=>17,
                 "hazel"=>1,
                 "white"=>1}}
```



## References

[**SWAPI - The Star Wars API**](https://swapi.dev) - All the Star Wars data you've ever wanted: Planets, Spaceships, Vehicles, People, Films and Species - From all SEVEN Star Wars films

- <https://github.com/Juriy/swapi/blob/master/resources/fixtures/people.json>
- <https://github.com/Juriy/swapi/blob/master/resources/fixtures/species.json>

