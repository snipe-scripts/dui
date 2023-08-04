-----------------For support, scripts, and more----------------
--------------- https://discord.gg/VGYkkAYVv2  -------------
---------------------------------------------------------------

local duiObj = {}
local currentRoom = nil
local currentDUIInfo = nil
local multiScreens = false
local currentName = nil

local function onEnter(self)
    currentRoom = self.name
    multiScreens = self.multiScreens
    local response = lib.callback.await("dui:server:getCurrentDUI", false, currentRoom)
    if not self.multiScreens then
        
        if response and next(response) then
            local duiInfo = response.duiInfo
            local url = response.url
            local width = response.width
            local height = response.height
            local txd = CreateRuntimeTxd(currentRoom.."_txd")
            duiObj[currentRoom] = CreateDui(url, width, height)
            local dui = GetDuiHandle(duiObj[currentRoom])
            local duiTexture = GetDuiHandle(duiObj[currentRoom])
            local duiTexture = CreateRuntimeTextureFromDuiHandle(txd, duiInfo.textName, dui)
            AddReplaceTexture(duiInfo.textDict, duiInfo.textName, currentRoom.."_txd", duiInfo.textName)
        end
    else
        Wait(100)
        if response and next(response) then
            if not duiObj[currentRoom] then
                duiObj[currentRoom] = {}
            end
            for k, v in pairs(response) do

                local duiInfo = v.duiInfo
                local url = v.url
                local width = v.width
                local height = v.height
                local txd = CreateRuntimeTxd(k.."_txd")
                duiObj[currentRoom][k] = CreateDui(url, width, height)
                local dui = GetDuiHandle(duiObj[currentRoom][k])
                local duiTexture = GetDuiHandle(duiObj[currentRoom][k])
                local duiTexture = CreateRuntimeTextureFromDuiHandle(txd, duiInfo.textName, dui)
                AddReplaceTexture(duiInfo.textDict, duiInfo.textName, k.."_txd", duiInfo.textName)
            end
        end
    end
end
local function onExit(self)
    if not multiScreens then
        if duiObj[self.name] then
            DestroyDui(duiObj[self.name])
        end
        duiObj[self.name] = nil
        RemoveReplaceTexture(DUIZones[self.name].duiInfo.textDict, DUIZones[self.name].duiInfo.textName)
        currentRoom = nil
        currentName = nil
        multiScreens = false
    else
        if duiObj[self.name] then
            for k, v in pairs(duiObj[self.name]) do
                DestroyDui(v)
            end
            duiObj[self.name] = nil
            -- RemoveReplaceTexture(DUIZones[self.name].duiInfo.textDict, DUIZones[self.name].duiInfo.textName)
            for k, v in pairs(DUIZones[self.name].dui) do
                RemoveReplaceTexture(v.duiInfo.textDict, v.duiInfo.textName)
            end
            currentRoom = nil
            currentName = nil
            multiScreens = false
        end
    end
end

CreateThread(function()
    for k, v in pairs(DUIZones) do
        if v.enabled then
            if v.duiInfo then
                v.zone.onEnter = onEnter
                v.zone.onExit = onExit
                lib.zones.poly(v.zone)

                local name = v.zone.name
                local duiInfo = v.duiInfo
                exports["qb-target"]:AddBoxZone(v.zone.name, v.target.coords, v.target.length, v.target.width, {
                    name=v.zone.name,
                    heading=v.target.heading,
                    debugPoly = false,
                    minZ=v.target.minZ,
                    maxZ=v.target.maxZ
                },{
                    options = {
                        {
                            action = function()
                                changeImage(name, duiInfo)
                            end,
                            icon = "fas fa-laptop",
                            label = "Change Image",
                            job = v.job or "none"
                        },
                        {
                            action = function()
                                removeImage(name)
                            end,
                            icon = "fas fa-laptop",
                            label = "Remove Image",
                            job = v.job or "none"
                        },
                    },
                    distance = 2.5
                })
            else
                if v.dui then
                    v.zone.onEnter = onEnter
                    v.zone.onExit = onExit
                    v.zone.multiScreens = true
                    lib.zones.poly(v.zone)

                    for index, data in pairs(v.dui) do
                        local name = index
                        local duiInfo = data.duiInfo
                        exports["qb-target"]:AddBoxZone(v.zone.name.."_"..name, data.target.coords, data.target.length, data.target.width, {
                            name=v.zone.name.."_"..name,
                            heading=data.target.heading,
                            debugPoly = false,
                            minZ=data.target.minZ,
                            maxZ=data.target.maxZ
                        },{
                            options = {
                                {
                                    action = function()
                                        changeImage(v.zone.name.."_"..name, data.duiInfo)
                                    end,
                                    icon = "fas fa-laptop",
                                    label = "Change Image",
                                    job = v.job or "all"
                                },
                                {
                                    action = function()
                                        removeImage(v.zone.name.."_"..name)
                                    end,
                                    icon = "fas fa-laptop",
                                    label = "Remove Image",
                                    job = v.job or "all"
                                },
                            },
                            distance = 2.5
                        })
                    end
                end
            end
        end
    end
end)

function changeImage(name, duiInfo)
    currentDUIInfo = duiInfo
    if multiScreens then
        currentName = name
    end
    SendNUIMessage({
        action = "start"
    })
    SetNuiFocus(true, true)
end

function removeImage(name)
    TriggerServerEvent("dui:server:removeImage", name)
end

RegisterNetEvent("dui:client:removeImage", function(name)
    if currentRoom == nil then
        return
    end
    if currentRoom ~= name then
        return
    end
    if duiObj[name] then
        DestroyDui(duiObj[name])
    end
    duiObj[name] = nil
    RemoveReplaceTexture(DUIZones[name].duiInfo.textDict, DUIZones[name].duiInfo.textName)
end)


RegisterNUICallback('CloseDocument', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('Invalid', function()
    SetNuiFocus(false, false)
    lib.notify({description = "Invalid URL", type = "error"})
end)

RegisterNUICallback('PrintDocument', function(data)
    SetNuiFocus(false, false)
    local url = data.url
    local width = data.width
    local height = data.height

    
    if duiObj[currentRoom] and not multiScreens then
        DestroyDui(duiObj[currentRoom])
        duiObj[currentRoom] = nil
    else
        if duiObj[currentRoom] and duiObj[currentRoom][currentName] then
            DestroyDui(duiObj[currentRoom][currentName])
            duiObj[currentRoom][currentName] = nil
        end
    end
    RemoveReplaceTexture(currentDUIInfo.textDict, currentDUIInfo.textName)
    
    TriggerServerEvent("dui:server:changeImage", currentRoom, url, width, height, currentDUIInfo, currentName)

    currentDUIInfo = nil
    currentName = nil
end)

RegisterNetEvent("dui:client:syncTextures", function(room, url, width, height, duiInfo, name)
    if currentRoom == nil then
        return
    end
    if currentRoom ~= room then
        return
    end

    if duiObj[room] and not multiScreens then
        DestroyDui(duiObj[room])
        RemoveReplaceTexture(duiInfo.textDict, duiInfo.textName)
        duiObj[room] = nil
    else
        if duiObj[room] and duiObj[room][name] then
            DestroyDui(duiObj[room][name])
            RemoveReplaceTexture(duiInfo.textDict, duiInfo.textName)
            duiObj[room][name] = nil
        end
    end
    if not multiScreens then
        local txd = CreateRuntimeTxd(currentRoom.."_txd")
        duiObj[currentRoom] = CreateDui(url, width, height)
        local dui = GetDuiHandle(duiObj[currentRoom])
        local tx = CreateRuntimeTextureFromDuiHandle(txd, "doc_png", dui)
        AddReplaceTexture(duiInfo.textDict, duiInfo.textName, currentRoom.."_txd", "doc_png")
    else
        local txd = CreateRuntimeTxd(name.."_txd")
        if not duiObj[currentRoom] then
            duiObj[currentRoom] = {}
        end
        duiObj[currentRoom][name] = CreateDui(url, width, height)
        local dui = GetDuiHandle(duiObj[currentRoom][name])
        local tx = CreateRuntimeTextureFromDuiHandle(txd, "doc_png", dui)
        AddReplaceTexture(duiInfo.textDict, duiInfo.textName, name.."_txd", "doc_png")
    end
end)

AddEventHandler("onResourceStop", function()
    if GetCurrentResourceName() ~= "dui" then
        return
    end
    for k, v in pairs(duiObj) do
        
        if type(v) == "number" then
            DestroyDui(v)
            duiObj[k] = nil
        else
            for _, data in pairs(v) do
                DestroyDui(data)
            end
            duiObj[k] = nil
        end
    end
    for k, v in pairs(DUIZones) do
        if v.duiInfo then
            RemoveReplaceTexture(v.duiInfo.textDict, v.duiInfo.textName)
        end
        if v.dui then
            for k, v in pairs(v.dui) do
                RemoveReplaceTexture(v.duiInfo.textDict, v.duiInfo.textName)
            end
        end
    end
end)
