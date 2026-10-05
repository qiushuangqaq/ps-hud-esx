local ESX = exports["es_extended"]:getSharedObject()

local function isAdmin(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer and (xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin') then
        return true
    end
    return IsPlayerAceAllowed(src, 'command')
end

RegisterNetEvent('hud:server:GetMoney', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer ~= nil then
        local cash = xPlayer.getMoney()
        local bank = xPlayer.getAccount('bank') and xPlayer.getAccount('bank').money or 0
        TriggerClientEvent('hud:client:OnMoneyChange', src, cash, bank)
    end
end)

RegisterNetEvent('hud:server:MalusCheck', function()
end)

ESX.RegisterCommand('cash', 'user', function(xPlayer, args, showError)
    local cashamount = xPlayer.getMoney()
    TriggerClientEvent('hud:client:ShowAccounts', xPlayer.source, 'cash', cashamount)
end, false, { help = Lang:t('info.check_cash_balance') })

ESX.RegisterCommand('bank', 'user', function(xPlayer, args, showError)
    local bankAccount = xPlayer.getAccount('bank')
    local bankamount = bankAccount and bankAccount.money or 0
    TriggerClientEvent('hud:client:ShowAccounts', xPlayer.source, 'bank', bankamount)
end, false, { help = Lang:t('info.check_bank_balance') })

ESX.RegisterCommand('dev', 'admin', function(xPlayer, args, showError)
    TriggerClientEvent("qb-admin:client:ToggleDevmode", xPlayer.source)
end, false, { help = Lang:t('info.toggle_dev_mode') })

RegisterNetEvent('hud:server:saveUIData', function(data)
    local src = source
    if not isAdmin(src) then
		return
	end

    local xPlayer = ESX.GetPlayerFromId(src)
	if not xPlayer then return end

    local uiConfigData = {}
    uiConfigData.icons = {}

    local path = GetResourcePath(GetCurrentResourceName())
    path = path:gsub('//', '/')..'/uiconfig.lua'
    local file = io.open(path, 'w+')

    local heading = "UIConfig = {}\n"
    file:write(heading)

    file:write("\nUIConfig.icons = {}\n")
    
    local iconKeys = {}
    for k, _ in pairs(data.icons) do
        table.insert(iconKeys, k)
    end
    table.sort(iconKeys)

    for _, iconName in ipairs(iconKeys) do
        uiConfigData.icons[iconName] = {}

        local iconLabel = "\nUIConfig.icons['"..iconName.."'] = {"
        file:write(iconLabel)

        local iconValues = {}
        for k, _ in pairs(data.icons[iconName]) do
            table.insert(iconValues, k)
        end
        table.sort(iconValues)

        for _, iconValueName in ipairs(iconValues) do
            local str
            local v = data.icons[iconName][iconValueName]
            uiConfigData.icons[iconName][iconValueName] = v
            if type(v) == "string" then
                str = ("\n    %s = '%s',"):format(iconValueName, v)
            else
                str = ("\n    %s = %s,"):format(iconValueName, v)
            end
            file:write(str)
        end
        file:write("\n}\n")
    end


    local layoutLabel = "\nUIConfig.layout = {"
    file:write(layoutLabel)
    for layoutName, layoutVal in pairs(data.layout) do
        local str
        if type(layoutVal) == "string" then
            str = ("\n    %s = '%s',"):format(layoutName, layoutVal)
        else
            str = ("\n    %s = %s,"):format(layoutName, layoutVal)
        end
        file:write(str)
    end
    file:write("\n}\n")
    uiConfigData.layout = data.layout


    file:write("\nUIConfig.colors = {}\n")
    uiConfigData.colors = {}

    local colorKeys = {}
    for k, _ in pairs(data.colors) do
        table.insert(colorKeys, k)
    end
    table.sort(colorKeys)

    for _, colorName in ipairs(colorKeys) do
        uiConfigData.colors[colorName] = {}
        uiConfigData.colors[colorName].colorEffects = {}

        local colorLabel = "\nUIConfig.colors['"..colorName.."'] = {"
        file:write(colorLabel)

        local colorEffectsLabel = "\n    colorEffects = {"
        file:write(colorEffectsLabel)

        for k, v in ipairs(data.colors[colorName].colorEffects) do
            local colorEffectIndexLabel = "\n        ["..k.."] = {"
            file:write(colorEffectIndexLabel)

            local colorEffect = data.colors[colorName].colorEffects[k]
            local colorEffectkeys = {}
            for scekey, _ in pairs(colorEffect) do
                table.insert(colorEffectkeys, scekey)
            end
            table.sort(colorEffectkeys)

            table.insert(uiConfigData.colors[colorName].colorEffects, colorEffect)

            for _, CEKey in ipairs(colorEffectkeys) do
                local str
                if type(colorEffect[CEKey]) == "string" then
                    str = ("\n            %s = '%s',"):format(CEKey, colorEffect[CEKey])
                else
                    str = ("\n            %s = %s,"):format(CEKey, colorEffect[CEKey])
                end
                file:write(str)
            end
            file:write("\n        },")
        end
        file:write("\n    },")
        file:write("\n}\n")
    end

    file:close()

    UIConfig = uiConfigData

    TriggerClientEvent('hud:client:UpdateUISettings', -1, uiConfigData)
end)

ESX.RegisterServerCallback('hud:server:getMenu', function(source, cb)
    cb(Config.Menu)
end)

ESX.RegisterServerCallback('hud:server:getRank', function(source, cb)
    if isAdmin(source) then
        cb(true)
    else
        cb(false)
    end
end)
