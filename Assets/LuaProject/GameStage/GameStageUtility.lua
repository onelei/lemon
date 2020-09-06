---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by onelei.
--- DateTime: 2020/9/6 20:13
---

---@class GameStageUtility

local GameStageBase        = require("GameStage.GameStageBase")
local GameStageEntry        = require("GameStage.GameStageEntry")
local GameStageLogin        = require("GameStage.GameStageLogin")
local GameStageHotUpdate    = require("GameStage.GameStageHotUpdate")
local GameStageCity         = require("GameStage.GameStageCity")
local GameStageBattle       = require("GameStage.GameStageBattle")

GameStageUtility = {}

local self = GameStageUtility

self.EGameStage =
{
    None = 0,
    Entry = 1,
    Login = 2,
    HotUpdate = 3,
    City = 4,
    Battle = 5,
    Num = 6,
}


function GameStageUtility.Init()

    self.__GameStageGroup = {}
    self.__GameStageGroup[self.EGameStage.None]             = GameStageBase.new()
    self.__GameStageGroup[self.EGameStage.Entry]            = GameStageEntry.new()
    self.__GameStageGroup[self.EGameStage.Login]            = GameStageLogin.new()
    self.__GameStageGroup[self.EGameStage.HotUpdate]        = GameStageHotUpdate.new()
    self.__GameStageGroup[self.EGameStage.City]             = GameStageCity.new()
    self.__GameStageGroup[self.EGameStage.Battle]           = GameStageBattle.new()

    self.__eCurGameStage = self.EGameStage.None
    self.__ePreGameStage = self.EGameStage.None

    ---enter Entry
    self.Enter(self.EGameStage.Entry)
end

function GameStageUtility.Enter(eGameStage)
    if self.__ePreGameStage == eGameStage then
        return
    end

    if not self.__GameStageGroup[eGameStage] then
        return
    end

    self.__ePreGameStage = self.__eCurGameStage
    self.__eCurGameStage = eGameStage

    local preAction = self.GetAction(self.GetPreStage())
    if preAction then
        preAction:OnExit()
    end

    local curAction = self.GetAction(self.GetCurStage())
    if curAction then
        curAction:OnEnter()
    end
end

function GameStageUtility.GetPreStage()
    return self.__ePreGameStage
end

function GameStageUtility.GetCurStage()
    return self.__eCurGameStage
end

function GameStageUtility.GetAction(eGameStage)
    if not eGameStage then
        return
    end

    return self.__GameStageGroup[eGameStage]
end

self.Init()

return GameStageUtility