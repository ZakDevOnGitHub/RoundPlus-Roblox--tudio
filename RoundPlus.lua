--[[
	RoundPlus by Krusher741
	Description: This module allows developers to round down, up, or to a certain decimal point of their desire, facilitating accurrate rounded numbers contrary to LuaU's default rounding methods.
	Usage: "local RoundPlus = require([Directory of RoundPlus])"
	Last changed: 10/11/2025
]]--

local module = {}

-- Rounds a number DOWN from the nearest user-specified decimal point e.g. Setting 1 for the nearest decimal point will round down to 0.X
function module.floor(number, nearestDecimalPoint)
	if typeof(number) == typeof(1) then
	else
		warn("RoundPlus v1.0 : " .. tostring(number) .. " is NOT a valid number type or is nil!")
		return
	end
	
	if typeof(nearestDecimalPoint) == typeof(1) then
	else
		warn("RoundPlus v1.0 : " .. tostring(nearestDecimalPoint) .. " is NOT a valid number type or is nil!")
		return
	end
	
	local Split = string.split(tostring(number), ".")
	
	if #Split[2] <=  nearestDecimalPoint then
		warn("RoundPlus v1.0 : Specified decimal place " .. tostring(nearestDecimalPoint) .. " is OUT OF BOUNDS! Specified decimal place must be at least LESS than the amount of decimal places in the number!")
		return
	end
	
	local WholeNumber = Split[1]
	
	local DecimalNumber = ""
	
	local SplitDecimals = Split[2] and string.split(Split[2], "") or {}
	
	for I, str in pairs(SplitDecimals) do
		if I < nearestDecimalPoint then
			DecimalNumber = DecimalNumber .. str
		end
	end
	
	if DecimalNumber ~= "" then
		return tonumber(WholeNumber .. "." .. DecimalNumber)
	else
		return tonumber(WholeNumber)
	end
end

-- Rounds a number UP from the nearest user-specified decimal point e.g. Setting 1 for the nearest decimal point will round up to 0.X
function module.ceil(number, nearestDecimalPoint)
	if typeof(number) == typeof(1) then
	else
		warn("RoundPlus v1.0 : " .. tostring(number) .. " is NOT a valid number type or is nil!")
		return
	end

	if typeof(nearestDecimalPoint) == typeof(1) then
	else
		warn("RoundPlus v1.0 : " .. tostring(nearestDecimalPoint) .. " is NOT a valid number type or is nil!")
		return
	end

	if nearestDecimalPoint < 0 then
		return math.ceil(number)
	end

	local multiplier = math.pow(10, nearestDecimalPoint-1)
	local result = math.ceil(number * multiplier) / multiplier
	return result
end

-- Rounds a number to the nearest user-specified decimal point e.g. Setting 1 for the nearest decimal point will round down to 0.X
function module.round(number, nearestDecimalPoint)
	if typeof(number) == typeof(1) then
	else
		warn("RoundPlus v1.0 : " .. tostring(number) .. " is NOT a valid number type or is nil!")
		return
	end

	if typeof(nearestDecimalPoint) == typeof(1) then
	else
		warn("RoundPlus v1.0 : " .. tostring(nearestDecimalPoint) .. " is NOT a valid number type or is nil!")
		return
	end

	if nearestDecimalPoint < 0 then
		return math.ceil(number)
	end
	
	local numSplit = string.split(number, ".")
	local decSplit = string.split(numSplit[2], "")
	
	if #decSplit <=  nearestDecimalPoint then
		warn("RoundPlus v1.0 : Specified decimal place " .. tostring(nearestDecimalPoint) .. " is OUT OF BOUNDS! Specified decimal place must be at least LESS than the amount of decimal places in the number!")
		return
	end
	
	if decSplit[nearestDecimalPoint+1] >= 5 then
		return module.ceil(number, nearestDecimalPoint)
	else
		return module.floor(number, nearestDecimalPoint)
	end
end

return module