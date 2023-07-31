-----------------For support, scripts, and more----------------
--------------- https://discord.gg/VGYkkAYVv2  -------------
---------------------------------------------------------------

local duiObj = {}
local currentRoom = nil
local currentDUIInfo = nil

local function onEnter(self)
    currentRoom = self.name
    local response = lib.callback.await("dui:server:getCurrentDUI", false, currentRoom)
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
end

local function onExit(self)
    if duiObj[self.name] then
        DestroyDui(duiObj[self.name])
    end
    duiObj[self.name] = nil
    RemoveReplaceTexture(DUIZones[self.name].duiInfo.textDict, DUIZones[self.name].duiInfo.textName)
    currentRoom = nil
end

CreateThread(function()
    for k, v in pairs(DUIZones) do
        if v.enabled then
            v.zone.onEnter = onEnter
            v.zone.onExit = onExit
            lib.zones.poly(v.zone)

            local name = v.zone.name
            local duiInfo = v.duiInfo
            local business = v.business
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
        end
    end
end)

function changeImage(name, duiInfo)
    currentDUIInfo = duiInfo
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

    
    if duiObj[currentRoom] then
        DestroyDui(duiObj[currentRoom])
    end
    RemoveReplaceTexture(currentDUIInfo.textDict, currentDUIInfo.textName)
    duiObj[currentRoom] = nil
    TriggerServerEvent("dui:server:changeImage", currentRoom, url, width, height, currentDUIInfo)

    currentDUIInfo = nil
    
end)

RegisterNetEvent("dui:client:syncTextures", function(room, url, width, height, duiInfo)
    if currentRoom == nil then
        return
    end
    if currentRoom ~= room then
        return
    end

    if duiObj[room] then
        DestroyDui(duiObj[room])
        RemoveReplaceTexture(duiInfo.textDict, duiInfo.textName)
        duiObj[room] = nil
    end
    local txd = CreateRuntimeTxd(currentRoom.."_txd")
    duiObj[currentRoom] = CreateDui(url, width, height)
    local dui = GetDuiHandle(duiObj[currentRoom])
    local tx = CreateRuntimeTextureFromDuiHandle(txd, "doc_png", dui)
    AddReplaceTexture(duiInfo.textDict, duiInfo.textName, currentRoom.."_txd", "doc_png")
end)

AddEventHandler("onResourceStop", function()

    for k, v in pairs(duiObj) do
        DestroyDui(v)
    end
    for k, v in pairs(DUIZones) do
        RemoveReplaceTexture(v.duiInfo.textDict, v.duiInfo.textName)
    end
end)
