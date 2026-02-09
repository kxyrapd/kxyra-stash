local QBCore = exports['qb-core']:GetCoreObject()

-- Resource başladıktan sonra ortak (non-private) stash'leri register et
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    for key, stash in pairs(Config.Stashs) do
        if not stash.private then
            local groups = nil
            if stash.job and stash.job ~= 'all' then
                groups = { stash.job } -- job erişimi için grup tablosu
            end

            -- id, label, slots, maxWeight, owner, groups, coords
            exports.ox_inventory:RegisterStash(stash.label, stash.label, stash.slots, stash.maxweight, nil, groups, stash.coord)
            print(("Registered shared stash: %s (job=%s)"):format(stash.label, stash.job or "all"))
        end
    end
end)

-- Depo açma isteği
RegisterNetEvent("depo:open", function(stashKey)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Config.Stashs[stashKey] then return end
    local stash = Config.Stashs[stashKey]

    -- İş kontrolü (job)
    if stash.job and stash.job ~= 'all' then
        if not Player or Player.PlayerData.job.name ~= stash.job then
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Bu depoya erişim yetkin yok!'})
            return
        end
    end

    if stash.private then
        -- Kişisel depo: citizenid ile owner string olarak kayıt edelim
        local citizenid = Player and Player.PlayerData.citizenid or tostring(src)
        local personalId = ("%s_%s"):format(stash.label, citizenid)

        -- Register kişiye özel stash (owner olarak citizenid veriyoruz)
        exports.ox_inventory:RegisterStash(personalId, stash.label, stash.slots, stash.maxweight, citizenid, nil, stash.coord)

        -- Server-side export ile zorla aç (server export)
        exports.ox_inventory:forceOpenInventory(src, 'stash', personalId)
    else
        -- Ortak depo zaten onResourceStart'ta register edildi yukarıda
        exports.ox_inventory:forceOpenInventory(src, 'stash', stash.label)
    end
end)
