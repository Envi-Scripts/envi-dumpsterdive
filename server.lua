if Config.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
    RegisterServerEvent('envi-dumpsterdive:rewards') 
    AddEventHandler('envi-dumpsterdive:rewards',function(luck)
        local _source = source
        local xPlayer  = ESX.GetPlayerFromId(source)
        local common = Config.CommonRewards[math.random(#Config.CommonRewards)]
        local uncommon = Config.UncommonRewards[math.random(#Config.UncommonRewards)]
        local rare = Config.RareRewards[math.random(#Config.RareRewards)]
        if luck <= 14 then
            local common = Config.CommonRewards[math.random(#Config.CommonRewards)]
            xPlayer.addInventoryItem(common,math.random(1, math.ceil(Config.MaxCommonReward/3)))
            local common = Config.CommonRewards[math.random(#Config.CommonRewards)]
            xPlayer.addInventoryItem(common,math.random(1, math.ceil(Config.MaxCommonReward/3)))
            local common = Config.CommonRewards[math.random(#Config.CommonRewards)]
            xPlayer.addInventoryItem(common,math.random(1, math.ceil(Config.MaxCommonReward/3)))
        elseif luck >= 14 and luck < 20 then
            xPlayer.addInventoryItem(common,math.random(1, math.ceil(Config.MaxCommonReward/2)))
            xPlayer.addInventoryItem(uncommon,math.random(1, Config.MaxUncommonReward))
        elseif luck == 20 then
            xPlayer.addInventoryItem(common,math.random(1, math.ceil(Config.MaxCommonReward/2)))
            xPlayer.addInventoryItem(rare,math.random(1, Config.MaxRareReward))
        end
    end)
elseif Config.Framework == 'qb' then
    QBCore = exports["qb-core"]:GetCoreObject()
    RegisterServerEvent('envi-dumpsterdive:rewards') 
    AddEventHandler('envi-dumpsterdive:rewards',function(luck)
        local _source = source
        local player  = QBCore.Functions.GetPlayer(source)
        local common = Config.CommonRewards[math.random(#Config.CommonRewards)]
        local uncommon = Config.UncommonRewards[math.random(#Config.UncommonRewards)]
        local rare = Config.RareRewards[math.random(#Config.RareRewards)]
        if luck <= 14 then
            local common = Config.CommonRewards[math.random(#Config.CommonRewards)]
            player.Functions.AddItem(common,math.random(1, math.ceil(Config.MaxCommonReward/3)))
            local common = Config.CommonRewards[math.random(#Config.CommonRewards)]
            player.Functions.AddItem(common,math.random(1, math.ceil(Config.MaxCommonReward/3)))
            local common = Config.CommonRewards[math.random(#Config.CommonRewards)]
            player.Functions.AddItem(common,math.random(1, math.ceil(Config.MaxCommonReward/3)))
        elseif luck >= 14 and luck < 20 then
            player.Functions.AddItem(common,math.random(1, math.ceil(Config.MaxCommonReward/2)))
            player.Functions.AddItem(uncommon,math.random(1, Config.MaxUncommonReward))
        elseif luck == 20 then
            player.Functions.AddItem(common,math.random(1, math.ceil(Config.MaxCommonReward/2)))
            player.Functions.AddItem(rare,math.random(1, Config.MaxRareReward))
        end
    end)
end

RegisterNetEvent("envi-dumpsterdive:Server:SyncEffect", function(pos)
    TriggerClientEvent("envi-dumpsterdive:Client:SyncEffect", -1, pos)
end)

