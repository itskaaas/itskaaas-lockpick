local VORPcore = exports.vorp_core:GetCore()

RegisterNetEvent('itskaaas-lockpick:server:checkLockpick')
AddEventHandler('itskaaas-lockpick:server:checkLockpick', function()
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local itemCount = exports.vorp_inventory:getItemCount(_source, nil, Config.LockpickItem)
    if itemCount > 0 then
        TriggerClientEvent('itskaaas-lockpick:client:checkLockpickResponse', _source, true)
    else
        TriggerClientEvent('itskaaas-lockpick:client:checkLockpickResponse', _source, false)
        VORPcore.NotifyBottomRight(_source, "You don't have a lockpick!", 4000)
    end
end)

RegisterNetEvent('itskaaas-lockpick:server:removeLockpick')
AddEventHandler('itskaaas-lockpick:server:removeLockpick', function()
    local _source = source
    if Config.BreakOnFail then
        exports.vorp_inventory:subItem(_source, Config.LockpickItem, 1)
        VORPcore.NotifyBottomRight(_source, "Your lockpick broke!", 4000)
    end
end)
