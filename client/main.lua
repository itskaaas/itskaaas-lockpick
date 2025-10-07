local VORPcore = exports.vorp_core:GetCore()

local function StartLockPick(callback)
    lockpickCallback = callback
    TriggerServerEvent('itskaaas-lockpick:server:checkLockpick')
end

AddEventHandler('itskaaas-lockpick:client:openLockpick', function(callback)
    StartLockPick(callback)
end)

RegisterNetEvent('itskaaas-lockpick:client:checkLockpickResponse')
AddEventHandler('itskaaas-lockpick:client:checkLockpickResponse', function(hasItem)
    if hasItem then
        openLockpick(true)
    else
        lockpickCallback(false)
    end
end)

RegisterCommand('testlockpick', function()
    StartLockPick(function(success)
        print('Lockpick result: ' .. tostring(success))
    end)
end, false)

RegisterNUICallback('callback', function(data, cb)
    openLockpick(false)
    if not data.success then
        TriggerServerEvent('itskaaas-lockpick:server:removeLockpick')
    end
    lockpickCallback(data.success)
    cb('ok')
end)

RegisterNUICallback('exit', function()
    openLockpick(false)
end)

openLockpick = function(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
    })
    SetCursorLocation(0.5, 0.2)
    lockpicking = bool
end

exports('initiate', function()
    local self = {}
    self.Start = function(gameType, config, callback)
        if gameType == 'lockpick' then
            StartLockPick(callback)
        else
            callback(false)
        end
    end
    return self
end)
