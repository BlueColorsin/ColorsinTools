local Tools_Version = "2.0"

Tools = {}

Tools.Table_SetTo = nil 
Tools.Sprites = {}

Tools.Dir = ''

Tools.BeatEvents = {}
Tools.StepEvents = {}
Tools.SectionEvents = {}

---Tools:makeObject Used for making luaSprites 
---@param self table use `:` instead of `.`
---@param tag string Lua Sprite tag or Object variable name
---@param image string mixed with the Directory var it can only take `.png` files 
---@param XY table `{[1] = x, [2] = y}`
---@param makeGraphicTab table `{[1] = width, [2] = height, [3] = color}` leave empty for no graphic
Tools.makeObject = function(self, tag, image, XY, makeGraphicTab)
    if image == nil then image = '' end
    makeLuaSprite(tag, self.Dir..image , XY[1], XY[2])
    
    if makeGraphicTab ~= nil then 
        makeGraphic(tag, makeGraphicTab[1], makeGraphicTab[2], 'FFFFFF') 
        setProperty(tag..".color", makeGraphicTab[3]) -- so you can use doTweenColor() on it
    end
    
    if self.Table_SetTo ~= nil then 
        table.insert(self.Table_SetTo, tag) 
    else 
        table.insert(self.Sprites, tag) 
    end
end

---Tools:makeAnimObject | similar too makeObject but it makes a animated sprite instead of a png/graphic sprite
---@param self table use `:` instead of `.`
---@param tag string Lua Sprite tag or Object variable name
---@param image string mixed with the Directory var it can only take `.png` files
---@param XY table `{[1] = x, [2] = y}`
---@param spriteType string if your sprite is a texture atlas put "tex" here 
Tools.makeAnimObject = function (self, tag, image, XY, spriteType)
    makeAnimatedLuaSprite(tag, self.Dir..image, XY[1], XY[2], spriteType)

    if self.Table_SetTo ~= nil then 
        table.insert(self.Table_SetTo, tag) 
    else 
        table.insert(self.Sprites, tag) 
    end
end

---Tools.setObjectParams | Used for setting a mass amount of lua object settings at once
---@param tag string Lua Sprite tag or Object variable name
---@param scaleXY_table table {`scaleX`, `scaleY`}
---@param scrollFactorXY_table table {`scrollFactorX`, `scrollFactorX`}
---@param FlipX boolean used to flip sprites along there X axis 
---@param object_Order number sets the object order to the input
---@param Camera string Default Cameras : `game`, `hud`, `other`
Tools.setObjectParams = function (tag, scaleXY_table, scrollFactorXY_table, FlipX, object_Order, Camera)
    if scaleXY_table then
        setProperty(tag..".scale.x", scaleXY_table[1])
        setProperty(tag..".scale.y", scaleXY_table[2])
    end
    if scrollFactorXY_table then
        setScrollFactor(tag, scrollFactorXY_table[1], scrollFactorXY_table[2])
    end
    if FlipX then
        setProperty(tag..".flipX", FlipX)
    end
    if object_Order then
        setObjectOrder(tag, object_Order)
    end
    if Camera then
        setObjectCamera(tag, Camera)
    end
end

---Tools.addObjectsByTable | adds a set of objects that are in a table, useful with the Table_SetTo table or Tools.Sprites
---@param inputTable _G Input a table, preferably one made with the Table_SetTo and makeObject pair but any would work
---@param onTop table Table should be formatted like {false, true, false, true}
Tools.addObjectsByTable = function(inputTable, onTop)
    for i = 1,#inputTable do 
        addLuaSprite(inputTable[i], onTop[i])
    end
end

---Tools.flashObj | can flash any object 
---@param self table use `:` instead of `.`
---@param tag string the Object to get flashed 
---@param startEndVal table {startingValue:float, endingValue:float}
---@param time number how long it will take to go away
---@param ease string a ease in the FlxEase library
Tools.flashObj = function (self,tag, startEndVal, time, ease)
    setProperty(tag..".alpha", startEndVal[1])
    doTweenAlpha(self.RNG(), tag, startEndVal[2], time, ease)
end

---Tools.RNG | Returns a random string using math.random()
Tools.RNG = function()
    return tostring(math.random())
end

---Tools.test | Used to test if the script has worked
Tools.test = function ()
    debugPrint("ColorsinTools["..Tools_Version.."] is working")
end

--Psych Functions
function onBeatHit() if Tools.BeatEvents[curBeat] then Tools.BeatEvents[curBeat]() end end
function onStepHit() if Tools.StepEvents[curStep] then Tools.StepEvents[curStep]() end end
function onSectionHit() if Tools.SectionEvents[curSection] then Tools.SectionEvents[curSection]() end end

return Tools