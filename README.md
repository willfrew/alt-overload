# alt-øverload
Operator overloading for Javascript.

# Usage
```coffeescript
require 'alt-overload'

ø.def Array, '+', Array, (a, b) ->
    a.concat b

ø [1,2,3] + [4,5,6]
# => [1,2,3,4,5,6]
```
