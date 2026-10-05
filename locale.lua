
Locale = Locale or {}
Locale.__index = Locale

function Locale:new(opts)
    opts = opts or {}
    local obj = setmetatable({}, Locale)
    obj.phrases = opts.phrases or {}
    obj.warnOnMissing = opts.warnOnMissing
    obj.fallback = opts.fallback
    return obj
end

local function interpolate(str, data)
    if not data then return str end
    return (str:gsub("%%{(.-)}", function(key)
        local v = data[key]
        if v == nil then return "%{" .. key .. "}" end
        return tostring(v)
    end))
end

function Locale:t(key, data)
    if type(key) ~= "string" then return key end

    local value = self.phrases
    for part in key:gmatch("[^%.]+") do
        if type(value) ~= "table" then
            value = nil
            break
        end
        value = value[part]
    end

    if value == nil then
        if self.warnOnMissing then
            print(("[ps-hud] Missing locale phrase: %s"):format(key))
        end
        return key
    end

    if type(value) == "string" then
        return interpolate(value, data)
    end

    return value
end
