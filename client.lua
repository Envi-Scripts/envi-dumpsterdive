local dumpys = {-387405094,364445978,-515278816,-1340926540,-1831107703,1605769687,388197031,-1790177567,-876149596}
local diving = false
local searching = false
local onCooldown = false
if Config.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
elseif Config.Framework == 'qb' then
    QBCore = exports["qb-core"]:GetCoreObject()
end

local function LoadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

RegisterNetEvent('envi-dumpsterdive:goDiving', function(entity)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    local items_found = false
    if not DoesEntityExist(entity) then return end
    if not diving or searching then
        searching = true
        LoadAnimDict('missexile3')
        TaskPlayAnim(ped, 'missexile3', 'ex03_dingy_search_case_b_michael', 8.0, 8.0, -1, 1, 0, false, false, false)
        RemoveAnimDict('missexile3')
        Wait(math.random(3000, 8000))
        SetPedDesiredHeading(ped, heading)
        Wait(1000)
        LoadAnimDict('move_crawl')
        searching = false
        diving = true
        TaskPlayAnim(ped, 'move_crawl', 'onfront_fwd', 8.0, 8.0, -1, 1, 0, false, false, false)
        RemoveAnimDict('move_crawl')
        Wait(math.random(2000, 3000))
        FreezeEntityPosition(ped, true)
        Wait(math.random(500, 1500))
        FreezeEntityPosition(ped, false)
        ClearPedTasks(ped)
        if not onCooldown then
            local luck = math.random(1, 20)
            if luck >= 8 then
                local netId = NetworkGetNetworkIdFromEntity(entity)
                if netId ~= 0 then
                    TriggerServerEvent('envi-dumpsterdive:rewards', luck)
                   onCooldown = true
                    SetTimeout(Config.Cooldown * 1000, function()
                       onCooldown = false
                    end)
                    items_found = true
                else
                    print("Invalid entity")
                end
            end
        end
    end
    diving = false
    if not items_found then
        if Config.Framework == 'esx' then
            ESX.ShowNotification("Nothing intersting here..")
            return
        elseif Config.Framework == 'qb' then
            QBCore.Functions.Notify("Nothing intersting here..")
            return
        end
    end
end)

RegisterNetEvent("envi-dumpsterdive:Client:SyncEffect", function(pos)
    UseParticleFxAssetNextCall("core")
	local ped = PlayerPedId()
	local forward = GetEntityForwardX(ped)
    local dirt = StartNetworkedParticleFxNonLoopedAtCoord("bul_sand_loose_heli", vector3(pos.x + forward*math.random(-1,1), pos.y, pos.z-1.03), 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0)
    Wait(math.random(250,1000))
    UseParticleFxAssetNextCall("core")
    local dust = StartNetworkedParticleFxNonLoopedAtCoord("ent_sht_paper_bails", vector3(pos.x + forward*math.random(-1,1), pos.y, pos.z-1.03), 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0)
end)

CreateThread(function()
	while true do
		while diving do
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
			TriggerServerEvent("envi-dumpsterdive:Server:SyncEffect", pos)
            Wait(1500)
		end
        Wait(500)
	end
end)

if Config.Target == 'qtarget' then
    exports['qtarget']:AddTargetModel(dumpys, {
        options = {
            {
                icon = 'fa-solid fa-dumpster',
                label = "Go Dumpster Diving!",
                action = function(entity)
                    TriggerEvent('envi-dumpsterdive:goDiving', entity)
                end,
                canInteract = function(entity, distance, coords)
                    local targetCoords = GetEntityCoords(entity)
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    if targetCoords.z < playerCoords.z-1.5 and not diving and not searching then
                        return true
                    end
                    return false
                end,
                distance = 1.0,
            }
        },
    })
elseif Config.Target == 'ox_target' then
    local dumpsterdive = {
        {
            name = 'ox_target:diveIn',
            icon = 'fa-solid fa-dumpster',
            label = "Go Dumpster Diving!",
            onSelect = function(data)
                TriggerEvent('envi-dumpsterdive:goDiving', data.entity)
            end,
            canInteract = function(entity, distance, coords)
                local targetCoords = GetEntityCoords(entity)
                local playerCoords = GetEntityCoords(PlayerPedId())
                if targetCoords.z < playerCoords.z-1.5 and not diving and not searching then
                    return true
                end
                return false
            end,
        }
    }
    exports.ox_target:addModel(dumpys, dumpsterdive)
    
elseif Config.Target == 'qb-target' then
    exports['qb-target']:AddTargetModel(dumpys, {
        options = {
            {
                icon = 'fa-solid fa-dumpster',
                label = "Go Dumpster Diving!",
                action = function(entity)
                    TriggerEvent('envi-dumpsterdive:goDiving', entity)
                end,
                canInteract = function(entity, distance, coords)
                    local targetCoords = GetEntityCoords(entity)
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    if targetCoords.z < playerCoords.z-1.5 and not diving and not searching then
                        return true
                    end
                    return false
                end,
            }
        },
        distance = 1.0,
    }) 
end
