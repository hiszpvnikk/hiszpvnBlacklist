-- client.lua hiszpnBlacklist
ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        -- funkcja odpowiadajaca za sprawdzenie pojazdów
        if vehicle ~= 0 then
            local vehicleModel = GetEntityModel(vehicle)
            for _, blockedVehicle in ipairs(Config.Autazablokowane) do
                if vehicleModel == GetHashKey(blockedVehicle) then
                    SetEntityAsMissionEntity(vehicle, true, true)
                    DeleteVehicle(vehicle)
                    print('wyprintowales zablokowane auto pozderki misiu ;3')
                    break
                end
            end
        end

        -- funkcja odpowiadajaca za sprawdzenie broni
        for _, blockedWeapon in ipairs(Config.Broniezablokowane) do
            if HasPedGotWeapon(playerPed, GetHashKey(blockedWeapon), false) then
                RemoveWeaponFromPed(playerPed, GetHashKey(blockedWeapon))
                print('wyprintowales zablokowana klamke pozderki misiu ;3')
            end
        end
    end
end)
