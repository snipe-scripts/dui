-----------------For support, scripts, and more----------------
--------------- https://discord.gg/VGYkkAYVv2  -------------
---------------------------------------------------------------

local duiInfo = {}

RegisterServerEvent("dui:server:changeImage", function(currentRoom, url, width, height, currentDUIInfo, name)
    if not name then
        duiInfo[currentRoom] = {
            url = url,
            width = width,
            height = height,
            duiInfo = currentDUIInfo
        }
    else
        if not duiInfo[currentRoom] then
            duiInfo[currentRoom] = {}
        end
        duiInfo[currentRoom][name] = {
            url = url,
            width = width,
            height = height,
            duiInfo = currentDUIInfo
        }
    end
    TriggerClientEvent("dui:client:syncTextures", -1, currentRoom, url, width, height, currentDUIInfo, name)
end)

RegisterServerEvent("dui:server:removeImage", function(currentRoom, name)
    local sendDUIInfo = nil
    if name then
        if duiInfo[currentRoom] then
            sendDUIInfo = duiInfo[currentRoom][name]
            duiInfo[currentRoom][name] = nil
        end
    else
        sendDUIInfo = duiInfo[currentRoom]
        
        duiInfo[currentRoom] = nil
    end
    duiInfo[currentRoom] = nil
    TriggerClientEvent("dui:client:removeImage", -1, currentRoom, sendDUIInfo.duiInfo, name)
end)

lib.callback.register("dui:server:getCurrentDUI", function(source, currentRoom)
    return duiInfo[currentRoom]
end)