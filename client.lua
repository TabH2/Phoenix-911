-- Registering the chat command
RegisterCommand("911", function(source, args)
    local location = GetEntityCoords(PlayerPedId())

    -- Trigger the 'nearest-postal' resource to get the nearest postal code
    TriggerServerEvent("911MessagetoLEO", table.concat(args, " "), location)
end)

-- Event handler for receiving 911 messages
RegisterNetEvent('receive911Message')
AddEventHandler('receive911Message', function(message, postal)
    TriggerEvent('chatMessage', '911 Call', {255, 0, 0}, " (Postal: " .. postal .. ") " .. message)
end)

-- Event handler for notifying the player that the 911 call has been sent
RegisterNetEvent('notify911CallSent')
AddEventHandler('notify911CallSent', function()
    TriggerEvent('chatMessage', '911 System', {255, 0, 0}, 'We have routed your 911 call to dispatch! Local Law Enforcement will be enroute to your location.')
end)
