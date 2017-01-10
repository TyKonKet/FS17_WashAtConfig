--
-- WashAtConfig script
--
--
-- @author  TyKonKet
-- @date 10/01/2017

WashAtConfig = {};
WashAtConfig.name = "WashAtConfig";
WashAtConfig.debug = false;

function WashAtConfig:print(txt)
    if WashAtConfig.debug then
        print("[" .. self.name .. "] -> " .. txt);
    end
end

function WashAtConfig:loadMap(name)
    ChangeVehicleConfigEvent.run = Utils.prependedFunction(ChangeVehicleConfigEvent.run, WashAtConfig.changeVehicleConfigRun);
end

function WashAtConfig:deleteMap()
end

function WashAtConfig:keyEvent(unicode, sym, modifier, isDown)
end

function WashAtConfig:mouseEvent(posX, posY, isDown, isUp, button)
end

function WashAtConfig:update(dt)
end

function WashAtConfig:draw()
end

function WashAtConfig.changeVehicleConfigRun(event, connection)
    if not connection:getIsServer() then
        if event.vehicle.setDirtAmount ~= nil then
            event.vehicle:setDirtAmount(0, true);
        end
    end
end

addModEventListener(WashAtConfig)