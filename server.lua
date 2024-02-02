function getPostalCode(x, y, z)
    local postal = exports['nearest-postal']:getPostalServer({x, y, z})
    return postal and postal.code or nil
end

RegisterServerEvent('911MessagetoLEO')
AddEventHandler('911MessagetoLEO', function(message, location)
    for _, playerId in ipairs(GetPlayers()) do
        local player = Player(playerId)
        
        if player and player.state and player.state.DepartmentId then
            local departmentIdLEO = player.state.DepartmentId
            local postal = getPostalCode(location[1], location[2], location[3])

            print("Player ID: " .. playerId)
            print("Department ID is " .. departmentIdLEO)

            if departmentIdLEO == 1 or departmentIdLEO == 2 or departmentIdLEO == 3 or departmentIdLEO == 5 then
                TriggerClientEvent('receive911Message', playerId, message, postal)
                print("Message sent to LEO for Player ID: " .. playerId)
            end
        else
            print("Invalid player data for Player ID: " .. playerId)
        end
    end

    TriggerClientEvent('notify911CallSent', source)
end)
