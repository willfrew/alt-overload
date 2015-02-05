#require 'alt-overload'
require './index'

class Point
    constructor: (@x, @y) ->

# Custom operators for custom classes
ø.def Point, '<<', Point, (p1, p2) ->
    new Point (p1.x*p2.x), (p1.y*p2.y)

point1 = new Point 1, 3
point2 = new Point 2, 3

console.log ø point1 << point2

# Array Concatenation
ø.def Array, '+', Array, (arr1, arr2) ->
    arr1.concat arr2

console.log ø [1,2,3,4] + [5,6,7,8]

# Map
ø.def Function, '>=', Array, (f, xs) ->
    xs.map f

add2 = (x) ->
    x + 2

console.log ø add2 >= [1,2,3,4]

# Function composition
ø.def Function, '+', Function, (f, g) ->
    (args...) ->
        f g args...

add10 = (x) ->
    x + 10

add12 = ø add2 + add10
console.log add12 12
