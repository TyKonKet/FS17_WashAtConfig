--
-- WashAtConfig script
--
--
-- @author  TyKonKet
-- @date 10/01/2017

WashAtConfig = {};
WashAtConfig.name = "WashAtConfig";
WashAtConfig.debug = false;

function WashAtConfig:print(txt1, txt2, txt3, txt4, txt5, txt6, txt7, txt8, txt9)
    if self.debug then
        local args = {txt1, txt2, txt3, txt4, txt5, txt6, txt7, txt8, txt9};
        for i, v in ipairs(args) do
            if v then
                print("[" .. self.name .. "] -> " .. tostring(v));
            end
        end
    end
end

function WashAtConfig:initialize(missionInfo, missionDynamicInfo, loadingScreen)
    self = WashAtConfig;
    self:print("initialize()");
    ChangeVehicleConfigEvent.run = Utils.prependedFunction(ChangeVehicleConfigEvent.run, WashAtConfig.changeVehicleConfigRun);
end
g_mpLoadingScreen.loadFunction = Utils.prependedFunction(g_mpLoadingScreen.loadFunction, WashAtConfig.initialize);

function WashAtConfig:load(missionInfo, missionDynamicInfo, loadingScreen)
    self = WashAtConfig;
    self:print("load()");
    g_currentMission.missionInfo.saveToXML = Utils.appendedFunction(g_currentMission.missionInfo.saveToXML, self.saveSavegame);
end
g_mpLoadingScreen.loadFunction = Utils.appendedFunction(g_mpLoadingScreen.loadFunction, WashAtConfig.load);

function WashAtConfig:loadMap(name)
    self:print(("loadMap(name:%s)"):format(name));
    if self.debug then
        addConsoleCommand("AAAWashAtConfigeTestCommand", "", "TestCommand", self);
    end
    self:loadSavegame();
end

function WashAtConfig:loadMapFinished()
    self = WashAtConfig;
    self:print("loadMapFinished()");
end

function WashAtConfig:afterLoad()
    self = WashAtConfig;
    self:print("afterLoad");
end

function WashAtConfig:loadSavegame()
    self:print("loadSavegame()");
end

function WashAtConfig:saveSavegame()
    self = WashAtConfig;
    self:print("saveSavegame()");
end

function WashAtConfig:deleteMap()
    self:print("deleteMap()");
end

function WashAtConfig:TestCommand()
    return "This is a test command";
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