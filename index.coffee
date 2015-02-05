primes = require('thousandprimes')

ø = (x) ->
    stackSize = ø._stack.length
    operator = ø._lookups[stackSize][x]
    operand2 = ø._stack.pop()
    operand1 = ø._stack.pop()
    class1 = ø._getClass operand1
    class2 = ø._getClass operand2
    typeSig = ø._getTypeSignature class1, class2
    combinator = ø._defs[typeSig]?[operator]
    if combinator?
        return combinator operand1, operand2
    else
        console.log 'combinator not found!'
        return undefined

# Precomputed operator return values.
# Based on inputs being prime numbers (starting at 3) as strings.
ø._lookups =
    '2' :
        '35'   : '+'
        '-2'   : '-'
        '15'   : '*'
        '0.6'  : '/'
        '1'    : '&'
        '5'    : '&&'
        '6'    : '^'
        '7'    : '|'
        '3'    : '||'
        '96'   : '<<'
        '0'    : '>>'
        'true' : '<='
        'false': '>='

ø._supported = [
    '+', '-', '*', '/'
    '&&', '||', '<=', '>='
    '&', '^', '|', '<<', '>>'
]
# Stores operator overload definitions.
ø._defs = {}

# Stack of operands.
ø._stack = []

# TODO:
# Validate ø.def inputs
#   - Ensure Types are actually functions.
ø.def = (type1, op, type2, combinator) ->
    if op not in ø._supported
        throw new Error "Unsupported Operator: #{op}"
    typeSig = ø._getTypeSignature type1, type2
    ø._defs[typeSig] = {} if not ø._defs[typeSig]?
    ø._defs[typeSig][op] = combinator
    ø._overrideValueOf type1
    ø._overrideValueOf type2 if type1 isnt type2

ø._overrideValueOf = (type) ->
    type.prototype.valueOf = () ->
        ø._stack.push this
        return "#{primes[ø._stack.length]}"

ø._getTypeSignature = (t1, t2) ->
    constructors = (typeof t1 isnt 'string' and typeof t2 isnt 'string')
    if t1 is t2
        if constructors then t1.name else t1
    else
        if constructors then "#{t1.name}~#{t2.name}" else "#{t1}~#{t2}"

ø._getClass = (obj) ->
  obj.constructor.name


global.ø = ø
