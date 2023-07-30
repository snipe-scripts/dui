-----------------For support, scripts, and more----------------
--------------- https://discord.gg/VGYkkAYVv2  -------------
---------------------------------------------------------------

local duiInfo = {}

RegisterServerEvent("dui:server:changeImage", function(currentRoom, url, width, height, currentDUIInfo)
    duiInfo[currentRoom] = {
        url = url,
        width = width,
        height = height,
        duiInfo = currentDUIInfo
    }
    TriggerClientEvent("dui:client:syncTextures", -1, currentRoom, url, width, height, currentDUIInfo)
end)

RegisterServerEvent("dui:server:removeImage", function(currentRoom)
    duiInfo[currentRoom] = nil
    TriggerClientEvent("dui:client:removeImage", -1, currentRoom)
end)

lib.callback.register("dui:server:getCurrentDUI", function(source, currentRoom)
    return duiInfo[currentRoom]
end)