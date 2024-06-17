local isInJob = false
local isInJobText = "~w~[~g~E~w~]~y~ Garsonluk Mesleginde Gir~w~"
local SelectedDrink = "nil"
local BeerProp = "nil"

local Blips = {
    Text = ".Garsonluk Mesleği", sprite = 93, color = 5, scale = 0.9, x = 836.98, y = -115.2, z = 87.13
}

local Orders = {
    '~w~[~g~E~w~]~y~Servis~r~ Chiwas Regal ~w~',
    '~w~[~g~E~w~]~y~Servis~r~ Gilbeys Cin ~w~',
    '~w~[~g~E~w~]~y~Servis~r~ Absolute Vodka ~w~',
    '~w~[~g~E~w~]~y~Servis~r~ Calvados ~w~',
    '~w~[~g~E~w~]~y~Servis~r~ Coruba ROM ~w~',
}

local ChiwasRegalPrice = 258
local GilbeysCinPrice = 220
local AbsoluteVodkaPrice = 197
local CalvadosPrice = 173
local ROMPrice = 298

local FirstPedSelectedOrderPrice = nil

local Animations = {
    Sitting = "WORLD_HUMAN_SEAT_LEDGE",
    Sitting2 = "PROP_HUMAN_SEAT_BAR",
    Sitting3 = "WORLD_HUMAN_SEAT_LEDGE",
    Drinking = "PROP_HUMAN_SEAT_CHAIR_DRINK_BEER"
}

--- First Customer Ped Variables ---

local CurrentFirstPedStageText = ""

local FirstCustomerPedCoords = { x = 851.48, y = -112.6, z = 78.77, h = 100.25} 
local FirstCustomerPedSlideCoords = { x = 844.47, y = -113.2, z = 79.77, h = 107.79}
local FirstCustomerPedHash = 'a_m_m_indian_01'

local FirstCustomerPedSitCoords = nil
local FirstPedSelectedOrder = "thinking"
local Chairs = {
    vector3(842.88, -110.29, 78.30),
    vector3(835.17, -104.98, 78.30),
    vector3(845.4, -116.94, 78.30),
}
local FirstCustomerPedSitHeading = nil

local CustomerInPub = false
local ServicesTaked = false
--- --- --- --- --- --- --- --- --- --- --- --- 

--- Join Job ---

Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
        local playerLoc = GetEntityCoords(player, false)
        if GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, vector3(826.29, -109.81, 79.77), true) < 2 then      
            sleep = 5
            if isInJob == false and IsControlJustReleased(0, 38) then 
                DisableControlAction(0, 69, true)
                isInJobText = "~w~[~g~E~w~]~y~ Garsonluk Mesleginden Ayrıl~w~"
                isInJob = true
            elseif isInJob == true and IsControlJustReleased(0, 38) then
                DisableControlAction(0, 69, false)
                isInJob = false
                DeleteEntity(FirstCustomerPed)
                OrdersTaked = false 
                FirstCustomerPedSitCoords = nil
                SelectedDrink = "nil"
                FirstPedSelectedOrder = "thinking"
                CurrentFirstPedStageText = ""
                FirstCustomerPedSitHeading = nil
                ServicesTaked = false
                isInJobText = "~w~[~g~E~w~]~y~ Garsonluk Mesleginde Gir~w~"
            end
            DrawJobText3D(vector3(826.29, -109.81, 79.77), isInJobText)
        else           
            sleep = 1500
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
        local playerLoc = GetEntityCoords(player)
        if isInJob == true then
            sleep = 5
            if GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, vector3(837.46, -117.06, 79.77), true) < 0.9 then
                DrawText3D(vector3(837.46, -117.06, 79.77),"~w~[~g~E~w~]~y~ Al~r~ Chiwas Regal~w~")
                if IsControlJustReleased(0, 38) then
                    SelectedDrink = '~w~[~g~E~w~]~y~Servis~r~ Chiwas Regal ~w~'
                    BeerProp = 'prop_cs_beer_bot_03'
                    PlayPlayerTrayAnim()
                end
            elseif GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, vector3(835.75, -115.84, 79.77), true) < 0.9 then
                DrawText3D(vector3(835.75, -115.84, 79.77),"~w~[~g~E~w~]~y~ Al~r~ Gilbeys Cin~w~")
                if IsControlJustReleased(0, 38) then
                    SelectedDrink = '~w~[~g~E~w~]~y~Servis~r~ Gilbeys Cin ~w~'
                    BeerProp = 'prop_sh_beer_pissh_01'
                    PlayPlayerTrayAnim()
                end
            elseif GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, vector3(833.75, -114.66, 79.77), true) < 0.9 then
                DrawText3D(vector3(833.75, -114.66, 79.77),"~w~[~g~E~w~]~y~ Al~r~ Absolute Vodka~w~")
                if IsControlJustReleased(0, 38) then
                    SelectedDrink = '~w~[~g~E~w~]~y~Servis~r~ Absolute Vodka ~w~'
                    BeerProp = 'prop_cs_beer_bot_03'
                    PlayPlayerTrayAnim()
                end
            elseif GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, vector3(832.59, -114, 79.77), true) < 0.9 then
                DrawText3D(vector3(832.59, -114, 79.77),"~w~[~g~E~w~]~y~ Al~r~ Calvados~w~")
                if IsControlJustReleased(0, 38) then
                    SelectedDrink = '~w~[~g~E~w~]~y~Servis~r~ Calvados ~w~'
                    BeerProp = 'prop_cs_beer_bot_01lod'
                    PlayPlayerTrayAnim()
                end
            elseif GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, vector3(831.0, -113.13, 79.77), true) < 0.9 then
                DrawText3D(vector3(831.0, -113.13, 79.77),"~w~[~g~E~w~]~y~ Al~r~ Coruba ROM~w~")
                if IsControlJustReleased(0, 38) then
                    SelectedDrink = '~w~[~g~E~w~]~y~Servis~r~ Coruba ROM ~w~'
                    BeerProp = 'prop_cs_whiskey_bottle'
                    PlayPlayerTrayAnim()
                end
            end
        else
            sleep = 3000
        end
        Citizen.Wait(sleep)
    end
end)

--- Create First Customer ---

Citizen.CreateThread(function()
    while true do
        if isInJob == true then
            sleep = 6000
            if not DoesEntityExist(FirstCustomerPed) then
                CreateFirstCustomerPed() 
            end
        else
            sleep = 10000
        end
        Citizen.Wait(sleep)
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local player = PlayerPedId()
        local playerLoc = GetEntityCoords(player, false)

        if GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, FirstCustomerPedLoc.x, 836.334, -110.189, 79.79, true) < 50 then
            isInJob = false
            DeleteEntity(FirstCustomerPed)
            Citizen.Wait(2000)
            --- Reset Variables ---
            OrdersTaked = false 
            FirstCustomerPedSitCoords = nil
            SelectedDrink = "nil"
            FirstPedSelectedOrder = "thinking"
            CurrentFirstPedStageText = ""
            FirstCustomerPedSitHeading = nil
            ServicesTaked = false
            FirstPedSelectedOrderPrice = nil
            --- --- --- --- --- ---
        end
    end
end)
--- Drawing Text On First Ped ---

Citizen.CreateThread(function()
    while true do
        if isInJob == true then
            sleep = 5
            local player = PlayerPedId()
            local playerLoc = GetEntityCoords(player, false)
            local FirstCustomerPedLoc = GetEntityCoords(FirstCustomerPed, false)
            if GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, FirstCustomerPedLoc.x, FirstCustomerPedLoc.y, FirstCustomerPedLoc.z, true) < 1.6 then
                DrawText3D(vector3(FirstCustomerPedLoc.x, FirstCustomerPedLoc.y, FirstCustomerPedLoc.z), CurrentFirstPedStageText)
            end
        else
            sleep = 2000
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do

        if isInJob == true then
            sleep = 5
            local player = PlayerPedId()
            local playerLoc = GetEntityCoords(player, false)
            local FirstCustomerPedLoc = GetEntityCoords(FirstCustomerPed, false)
            if GetDistanceBetweenCoords(FirstCustomerPedLoc.x, FirstCustomerPedLoc.y, FirstCustomerPedLoc.z, 844.47, -113.2, 79.77, 107.79, true) < 2 and GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, FirstCustomerPedLoc.x, FirstCustomerPedLoc.y, FirstCustomerPedLoc.z, true) < 1.6 then
                CurrentFirstPedStageText = "~w~[~g~E~w~]~y~ Müsteriyi Yerlestir~w~"
                CustomerInPub = true
                if CustomerInPub == true and IsControlJustReleased(0, 38) then
                    SeatRandomForFirstPed()
                    CurrentFirstPedStageText = ""   
                    if FirstCustomerPedSitCoords == vector3(842.88, -110.29, 78.30) then
                        WaitTime = 2500
                        TaskPedSlideToCoord(FirstCustomerPed, 842.22, -110.9, 78.77, 49.75, 10.0)
                    elseif FirstCustomerPedSitCoords == vector3(835.17, -104.98, 78.30) then
                        TaskPedSlideToCoord(FirstCustomerPed, 834.59, -106.59, 78.77, 324.9, 10.0)
                        WaitTime = 8300
                    elseif FirstCustomerPedSitCoords == vector3(845.4, -116.94, 78.30) then
                        TaskPedSlideToCoord(FirstCustomerPed, 845.4, -116.94, 78.30, 324.9, 10.0)
                        WaitTime = 3000
                    end
                    Citizen.Wait(WaitTime)
                    CurrentFirstPedStageText = "~w~[~g~E~w~]~y~ Siparisleri Al~w~"   
                    OrdersTaked = true  
                    PlaceFirstCustomer()  
                    WaitTime = 0
                end
            end
        else
            sleep = 2000
        end
        Citizen.Wait(sleep)
    end
end)

--- Servicing First Customer Orders ---
--- Finishing First Customer Tasks ---
Citizen.CreateThread(function()
    while true do
        if isInJob == true then
            sleep = 5
            local player = PlayerPedId()
            local playerLoc = GetEntityCoords(player, false)
            local FirstCustomerPedLoc = GetEntityCoords(FirstCustomerPed, false)

            if GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, FirstCustomerPedLoc.x, FirstCustomerPedLoc.y, FirstCustomerPedLoc.z, true) < 1.6 and OrdersTaked == true and IsControlJustReleased(0, 38) then
                CreateRandomOrderForFirstPed()
                CurrentFirstPedStageText = FirstPedSelectedOrder
                ServicesTaked = true
                if GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, FirstCustomerPedLoc.x, FirstCustomerPedLoc.y, FirstCustomerPedLoc.z, true) < 1.6 and ServicesTaked == true and IsControlJustReleased(0, 38) and SelectedDrink == FirstPedSelectedOrder then
                    CustomerDrinkAnim()
                    ClearPedTasksImmediately(player)
                    DeleteObject(BeerBottle)
                    DeleteObject(Tray)
                    CurrentFirstPedStageText = ""
                    SelectedDrink = "nil"
                    Citizen.Wait(20000)
                    IsReadyForExit = true
                    TriggerServerEvent('dope-waiterJob:giveMoney', FirstPedSelectedOrderPrice)
                    FreezeEntityPosition(FirstCustomerPed, false)
                    if FirstCustomerPedSitCoords == vector3(842.88, -110.29, 78.30) then
                        ClearPedTasksImmediately(FirstCustomerPed)
                        SetEntityCoords(FirstCustomerPed, 842.43, -111.28, 78.77)
                        SetEntityHeading(FirstCustomerPed, 244.25)
                        Citizen.Wait(500)
                        TaskPedSlideToCoord(FirstCustomerPed, 849.52, -113.11, 79.45, 258.78, 10.0)

                    elseif FirstCustomerPedSitCoords == vector3(835.17, -104.98, 78.30) then
                        ClearPedTasksImmediately(FirstCustomerPed)
                        SetEntityCoords(FirstCustomerPed, 834.44, -107.1, 78.77)
                        SetEntityHeading(FirstCustomerPed, 242.25)
                        Citizen.Wait(500)
                        TaskPedSlideToCoord(FirstCustomerPed, 841.84, -111.41, 79.45, 249.03, 10.0)
                        Citizen.Wait(5000)
                        TaskPedSlideToCoord(FirstCustomerPed, 851.84, -113.23, 79.45, 249.03, 10.0)
                    elseif FirstCustomerPedSitCoords == vector3(845.4, -116.94, 78.30) then
                        ClearPedTasksImmediately(FirstCustomerPed)
                        SetEntityCoords(FirstCustomerPed, 844.98, -116.84, 78.77)
                        SetEntityHeading(FirstCustomerPed, 333.53)
                        Citizen.Wait(500)
                        TaskPedSlideToCoord(FirstCustomerPed, 849.25, -109.22, 79.57, 314.79, 10.0)
                    end
                    Citizen.Wait(10000)
                    DeleteEntity(FirstCustomerPed)
                    Citizen.Wait(2000)
                    --- Reset Variables ---
                    OrdersTaked = false 
                    FirstCustomerPedSitCoords = nil
                    SelectedDrink = "nil"
                    FirstPedSelectedOrder = "thinking"
                    CurrentFirstPedStageText = ""
                    FirstCustomerPedSitHeading = nil
                    ServicesTaked = false
                    FirstPedSelectedOrderPrice = nil
                    --- --- --- --- --- ---
                end
            end
        else
            sleep = 5000
        end
        Citizen.Wait(sleep)
    end
end)

-- --- Creating Blips ---

local blip = AddBlipForCoord(Blips.x, Blips.y, Blips.z)
SetBlipSprite(blip, Blips.sprite)
SetBlipDisplay(blip, 4)
SetBlipScale  (blip, Blips.scale)
SetBlipColour (blip, Blips.color)
SetBlipAsShortRange(blip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString(Blips.Text)
EndTextCommandSetBlipName(blip)


--- Finishing First Customer Tasks ---


function CreateFirstCustomerPed() 
	RequestModel(FirstCustomerPedHash)
    while not HasModelLoaded(FirstCustomerPedHash) do
	    Citizen.Wait(10)
    end
    FirstCustomerPed = CreatePed(1, FirstCustomerPedHash, FirstCustomerPedCoords.x, FirstCustomerPedCoords.y, FirstCustomerPedCoords.z, FirstCustomerPedCoords.h, false, false)
    SetEntityInvincible(FirstCustomerPed, true)
    SetBlockingOfNonTemporaryEvents(FirstCustomerPed, true)
    TaskPedSlideToCoord(FirstCustomerPed, FirstCustomerPedSlideCoords.x, FirstCustomerPedSlideCoords.y, FirstCustomerPedSlideCoords.z, FirstCustomerPedSlideCoords.h, 10.0)
end

function CreateRandomOrderForFirstPed()
    if FirstPedSelectedOrder == 'thinking' then
        local randomOrder = math.random(1, #Orders)
        selectedOrder = Orders[randomOrder]
        FirstPedSelectedOrder = selectedOrder
    end

    if FirstPedSelectedOrder == '~w~[~g~E~w~]~y~Servis~r~ Chiwas Regal ~w~' then
        FirstPedSelectedOrderPrice = ChiwasRegalPrice
    elseif FirstPedSelectedOrder ==  '~w~[~g~E~w~]~y~Servis~r~ Gilbeys Cin ~w~' then
        FirstPedSelectedOrderPrice = GilbeysCinPrice
    elseif FirstPedSelectedOrder ==  '~w~[~g~E~w~]~y~Servis~r~ Absolute Vodka ~w~' then
        FirstPedSelectedOrderPrice = AbsoluteVodkaPrice
    elseif FirstPedSelectedOrder ==  '~w~[~g~E~w~]~y~Servis~r~ Calvados ~w~' then
        FirstPedSelectedOrderPrice = CalvadosPrice
    elseif FirstPedSelectedOrder ==  '~w~[~g~E~w~]~y~Servis~r~ Coruba ROM ~w~' then   
        FirstPedSelectedOrderPrice = ROMPrice
    end
end

function SeatRandomForFirstPed()
    if FirstCustomerPedSitCoords == nil  then
        
        local randomChair = math.random(1, #Chairs)
        selectedSitCoords = Chairs[randomChair]
        FirstCustomerPedSitCoords = selectedSitCoords
    end
    if FirstCustomerPedSitCoords == vector3(842.88, -110.29, 78.30) then
        FirstCustomerPedSitHeading = 70.32
    elseif FirstCustomerPedSitCoords == vector3(835.17, -104.98, 78.30) then
        FirstCustomerPedSitHeading = 240.23
    elseif FirstCustomerPedSitCoords == vector3(845.4, -116.94, 78.30) then 
        FirstCustomerPedSitHeading = 148.63
    end
end

function PlaceFirstCustomer()
    SetEntityCoords(FirstCustomerPed, FirstCustomerPedSitCoords, false, false, false, false) 
    SetEntityHeading(FirstCustomerPed, FirstCustomerPedSitHeading)
    -- SetEntityVelocity(FirstCustomerPed, 0.0, 0.0, 0.0)
    -- SetEntityCollision(FirstCustomerPed, false, false)
    CustomerAnim()
    FreezeEntityPosition(FirstCustomerPed, true)
end

function CustomerAnim()
    TaskStartScenarioInPlace(FirstCustomerPed, Animations.Sitting3, 0, true) 
end
function CustomerDrinkAnim()
    ClearPedTasksImmediately(FirstCustomerPed)
    TaskStartScenarioInPlace(FirstCustomerPed, Animations.Drinking, 0, true) 
end

function PlayPlayerTrayAnim()
    local player = GetPlayerPed(-1)
    local AnimDict = "anim@heists@humane_labs@finale@keycards"

    RequestAnimDict(AnimDict)
    while not HasAnimDictLoaded(AnimDict) do
        Citizen.Wait(10)
    end

    if DoesEntityExist(Tray) and DoesEntityExist(BeerBottle) then
        DeleteObject(Tray)
        DeleteObject(BeerBottle)
    end

    TaskPlayAnim(player, AnimDict, "ped_a_enter_loop", 5.0, -1, -1, 50, 0, false, false, false)

    Tray = CreateObject(GetHashKey('prop_cs_silver_tray'), 842.88, -110.29, 78.30, true, true, true)
    AttachEntityToEntity(Tray, player, GetPedBoneIndex(player, 4137), 0.0, 0.0, 0.08, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, false)
    BeerBottle = CreateObject(GetHashKey(BeerProp), 842.88, -110.29, 78.30, true, true, true)
    if SelectedDrink == '~w~[~g~E~w~]~y~Servis~r~ Gilbeys Cin ~w~' then
        AttachEntityToEntity(BeerBottle, player, GetPedBoneIndex(player, 4137), 0.0, 0.0, 0.069, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, false)
    elseif SelectedDrink == '~w~[~g~E~w~]~y~Servis~r~ Chiwas Regal ~w~' or SelectedDrink == '~w~[~g~E~w~]~y~Servis~r~ Absolute Vodka ~w~' or 
    SelectedDrink == '~w~[~g~E~w~]~y~Servis~r~ Calvados ~w~' or SelectedDrink == '~w~[~g~E~w~]~y~Servis~r~ Coruba ROM ~w~' then
        AttachEntityToEntity(BeerBottle, player, GetPedBoneIndex(player, 4137), 0.0, 0.0, 0.205, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, false)
    end
end
--- Clearing Props ---
RegisterCommand('drop', function()
    ClearPedTasksImmediately(player)
    DeleteObject(Tray)
    DeleteObject(BeerBottle)
end)
--- --- --- --- --- ---

function DrawText3D(coord, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(coord.x, coord.y, coord.z)
	local px,py,pz=table.unpack(GetGameplayCamCoords()) 
	local scale = 0.3
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropshadow(0)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 380
        DrawRect(_x, _y + 0.0120, 0.0 + factor, 0.025, 41, 11, 41, 100)
	end
end
function DrawJobText3D(coord, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(coord.x, coord.y, coord.z)
	local px,py,pz=table.unpack(GetGameplayCamCoords()) 
	local scale = 0.3
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropshadow(0)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 380
        DrawRect(_x, _y + 0.0120, 0.0 + factor, 0.025, 41, 11, 41, 100)
	end
end




