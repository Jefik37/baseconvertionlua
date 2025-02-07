# Functions
`basetodec(number, base)` Converts a number from any base to decimal.<br>
`dectobase(number, base)` Converts a number from decimal to another base.<br>
`basetobase(number, base_origin, base_goal)` Converts a number from any base to any other base.

# Examples

Decimal to binary:
```lua
local baseconvertion = require('baseconvertion')

for i = -2, 2, 0.25 do
  print(i, baseconvertion.dectobase(i,2))
end
```

```
-2      -10
-1.75   -1.11
-1.5    -1.1
-1.25   -1.01
-1      -1
-0.75   -0.11
-0.5    -0.1
-0.25   -0.01
0       0
0.25    0.01
0.5     0.1
0.75    0.11
1       1
1.25    1.01
1.5     1.1
1.75    1.11
2       10
```

Hexadecimal to decimal:
```lua
local baseconvertion = require('baseconvertion')

for i = 8, 17 do
    print(baseconvertion.dectobase(i,16))
end
```

```
8
9
A
B
C
D
E
F
10
11
```

Hexadecimal to binary:
```lua
local baseconvertion = require('baseconvertion')

numbers = {-1000,-1001,'-1010',-1011,1100.10011,-1101.11,'1110'}

for i = 1, #numbers do
    print(baseconvertion.basetobase(numbers[i], 2, 16))
end
```

```
-8
-9
-A
-B
C.98
-D.C
E
```
