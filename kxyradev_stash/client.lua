local sleep

-- 3D text fonksiyonu
local function DrawText3D(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

-- Ana thread
CreateThread(function()
    while true do
        sleep = 1000
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        for k, v in pairs(Config.Stashs) do
            if #(pos - v.coord) < 2.0 then
                sleep = 0
                DrawMarker(2, v.coord.x, v.coord.y, v.coord.z - 0.2, 0, 0, 0, 0, 0, 0, 
                    0.3, 0.3, 0.3, 0, 150, 255, 200, false, true, 2, true, nil, nil, false)
                DrawText3D(v.coord + vector3(0,0,0.3), "[E] Depoyu Aç")

                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent("depo:open", k)
                end
            end
        end

        Wait(sleep)
    end
end)
