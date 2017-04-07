--
-- WashAtConfig
--
-- @author  TyKonKet
-- @date 10/01/2017
WashAtConfig = {};
WashAtConfig.name = "WashAtConfig";
WashAtConfig.debug = false;
WashAtConfig.washers = 0;

function WashAtConfig:print(text, ...)
    local start = string.format("[%s(%s)] -> ", self.name, getDate("%H:%M:%S"));
    local ptext = string.format(text, ...);
    print(string.format("%s%s", start, ptext));
end

function WashAtConfig:initialize(missionInfo, missionDynamicInfo, loadingScreen)
    self = WashAtConfig;
    ChangeVehicleConfigEvent.run = Utils.prependedFunction(ChangeVehicleConfigEvent.run, WashAtConfig.changeVehicleConfigRun);
    g_shopConfigScreen.setStoreItem = WashAtConfig.setStoreItem;
end
g_mpLoadingScreen.loadFunction = Utils.prependedFunction(g_mpLoadingScreen.loadFunction, WashAtConfig.initialize);

function WashAtConfig:load(missionInfo, missionDynamicInfo, loadingScreen)
    self = WashAtConfig;
    g_currentMission.loadMapFinished = Utils.appendedFunction(g_currentMission.loadMapFinished, self.loadMapFinished);
    g_currentMission.onStartMission = Utils.appendedFunction(g_currentMission.onStartMission, self.afterLoad);
    g_currentMission.onObjectCreated = Utils.appendedFunction(g_currentMission.onObjectCreated, WashAtConfig.onObjectCreated);
    g_currentMission.onObjectDeleted = Utils.appendedFunction(g_currentMission.onObjectDeleted, WashAtConfig.onObjectDeleted);
end
g_mpLoadingScreen.loadFunction = Utils.appendedFunction(g_mpLoadingScreen.loadFunction, WashAtConfig.load);

function WashAtConfig:loadMap(name)
end

function WashAtConfig:loadMapFinished()
    self = WashAtConfig;
end

function WashAtConfig:afterLoad()
    self = WashAtConfig;
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

function WashAtConfig:onObjectCreated(object)
    local isWasher = object.washerParticleSystems ~= nil;
    if isWasher then
        WashAtConfig.washers = WashAtConfig.washers + 1;
    end
end

function WashAtConfig:onObjectDeleted(object)
    local isWasher = object.washerParticleSystems ~= nil;
    if isWasher then
        WashAtConfig.washers = WashAtConfig.washers - 1;
    end
end

function WashAtConfig:setStoreItem(storeItem, vehicle, configBasePrice)
    self.storeItem = storeItem;
    self.vehicle = vehicle;
    configBasePrice = Utils.getNoNil(configBasePrice, 0);
    if configBasePrice == 0 then
        if WashAtConfig.washers <= 0 then
            configBasePrice = 250;
        end
    end
    self.configBasePrice = configBasePrice;
end

function WashAtConfig:changeVehicleConfigRun(connection)
    if not connection:getIsServer() and self.vehicle ~= nil and self.vehicle.isVehicleSaved and not self.vehicle.isControlled and g_currentMission:getHasPermission("sellVehicle", connection) then
        if self.vehicle.setDirtAmount ~= nil then
            self.vehicle:setDirtAmount(0, true);
        end
    end
end

addModEventListener(WashAtConfig);
