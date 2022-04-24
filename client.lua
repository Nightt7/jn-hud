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
                Wait(1000)

                self.triggerEvent('esx_status:getStatus', 'hunger', function(status) 
                    hunger = status.val / 10000 
                end)

                self.triggerEvent('esx_status:getStatus', 'thirst', function(status) 
                    thirst = status.val / 10000 
                end)

                self.sendNui({
                    type = 'interface:update',
                    health = math.ceil(GetEntityHealth(PlayerPedId()) / 2),
                    shield = GetPedArmour(PlayerPedId()),
                    hunger = hunger,
                    thirst = thirst,
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

RegisterNetEvent('onResourceStart', function()
    Status = Status()

    Status.init()
end)

RegisterNetEvent('playerLoaded', function()
    Status = Status()

    Status.init()
end)