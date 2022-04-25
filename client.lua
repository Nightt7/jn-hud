function Status()
    self = {}

    self.triggerEvent = function(e, ...)
        TriggerEvent(e, ...)
    end

    self.sendNui = function(data)
        SendNUIMessage(data)
    end

    self.init = function()
        CreateThread(function()
            while(true)do
                Wait(300)

                self.triggerEvent('esx_status:getStatus', 'hunger', function(status) 
                    hunger = math.ceil(status.val / 10000)
                end)

                self.triggerEvent('esx_status:getStatus', 'thirst', function(status) 
                    thirst = math.ceil(status.val / 10000)
                end)

                self.sendNui({
                    type = 'interface:update',
                    health = math.ceil(GetEntityHealth(PlayerPedId()) - 100),
                    shield = GetPedArmour(PlayerPedId()),
                    hunger = hunger,
                    thirst = thirst,
                    method = 'whenUse',
                    percent= 50,
                })

                if(IsPedInAnyVehicle(PlayerPedId()))then
                    DisplayRadar(true)
                else
                    DisplayRadar(false)
                end
            end
        end)
    end

    return self
end

CreateThread(function()
    Status = Status()

    SetTimeout(500, function()
        Status.init()
    end)
end)