local F = {}

local function reversetable(tbl)

    local n = #tbl
    for i = 1, math.floor(n / 2) do
        tbl[i], tbl[n - i + 1] = tbl[n - i + 1], tbl[i]
    end

    return tbl

end

local function totable(str)

    if str == nil then return nil end

    local tbl = {}
    for i = 1, #str do
        tbl[i] = str:sub(i, i)
    end
    return tbl
end

local function printtable(tbl)
    tbl = table.concat(tbl)
    print(tbl)
end

local function split(str, sep)
    local result = {}
    local pattern = string.format("([^%s]+)", sep)
    for part in string.gmatch(str, pattern) do
        table.insert(result, part)
    end
    return result
end

local function contains(tbl, value)
    for index, v in ipairs(tbl) do
        if v == value then
            return index
        end
    end
    return false
end

function F.dectobase(number, base)
    if base < 2 or base ~= math.floor(base)then return nil end
    number = tonumber(number)

    local integers = {}
    local fractionals = {}
    local dividend = 0
    local remainder = 0
    local negative = false

    if (string.sub(number,1,1)) == '-' then
        negative = true
        number = tonumber(string.sub(number,2,-1))
    end

    local integer = math.floor(number)
    local fractional = number-integer

    ------------------ INTEGER PART ------------------
    while integer >= base do
        remainder = integer % base
        table.insert(integers, remainder)
        integer = math.floor(integer / base)
    end

    table.insert(integers,integer)

    for i = 1, #integers do 
        if integers[i]>=10 then
            integers[i] = string.char(55+integers[i])
        end
    end

    integers = reversetable(integers)

    if negative then
        table.insert(integers,1,'-')
    end

    integers = table.concat(integers,'')
    ------------------ INTEGER PART ------------------

    ------------------ FRACTIONAL PART ------------------
    if fractional ~=0 then
        while fractional ~= 0 do
            fractional = fractional * base
            integer = math.floor(fractional)
            fractional = fractional - integer
            table.insert(fractionals, integer)
        end
        
        for i = 1, #fractionals do 
            if fractionals[i]>=10 then
                fractionals[i] = string.char(55+fractionals[i])
            end
        end

        fractionals = table.concat(fractionals,'')

        integers = table.concat({integers,fractionals}, '.')
    end
    ------------------ FRACTIONAL PART ------------------

    return integers

end

function F.basetodec(number, base)
    if base < 2 or base ~= math.floor(base)then return nil end

    local negative = false
    if (string.sub(number,1,1)) == '-' then
        negative = true
        number = tostring(string.sub(number,2,-1))
    end

    number = split(number,'.')
    local integer = totable(string.reverse(number[1]))
    local fractional = totable(number[2])
    local result = 0

    ------------------ INTEGER PART ------------------
    for i =1, #integer do

        if string.byte(integer[i])>=65 then
            integer[i] = string.byte(integer[i])-55
        end

        result = result + integer[i]*base^(i-1)
        
    end
    ------------------ INTEGER PART ------------------

    ------------------ FRACTIONAL PART ------------------
    if fractional ~=nil then
        for i =1, #fractional do

            if string.byte(fractional[i])>=65 then
                fractional[i] = string.byte(fractional[i])-55
            end
    
            result = result + fractional[i]*base^(-i)
            
        end
    end
    ------------------ FRACTIONAL PART ------------------

    if negative then
        result = -result
    end

    return result

end

function F.basetobase(number, base_origin, base_goal)

    local result = F.basetodec(number, base_origin)
    result = F.dectobase(result, base_goal)
    return result

end

return F
