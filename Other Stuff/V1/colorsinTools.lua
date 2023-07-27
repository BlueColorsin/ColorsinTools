Colorsin = "Tools :] \n By [BlueColorsin]"

return {
    spriteObjects = {},
    animatedObjects = {},
    graphicObjects = {},

    dir = "", --directory of the image/xml
    --var:addObject
    addObject = function(self, tag, image, PosX, PosY, onTop)
        makeLuaSprite(tag, self.dir..image, PosX, PosY)
        addLuaSprite(tag, onTop)
        table.insert(self.spriteObjects, tag)
    end,
    --var:newGraphic
    addGraphic = function(self, tag, PosX, PosY, onTop, Color, WidthX, HeightY)
        makeLuaSprite(tag, nil, PosX, PosY)
        makeGraphic(tag, WidthX, HeightY, Color)
        addLuaSprite(tag,onTop)	
        table.insert(self.graphicObjects, tag)
    end,
    --var:addAnimObj
    addAnimObj = function (self, tag, image, PosX, PosY, onTop)
        makeAnimatedLuaSprite(tag, self.dir..image, PosX, PosY)
        addLuaSprite(tag, onTop)
        table.insert(self.animatedObjects, tag)
    end,
    --var.setObjParam
    setObjParams = function (tag,setScale,setOrder,setCamera)
        scaleObject(tag, setScale, setScale)
        setObjectOrder(tag, setOrder)
        setObjectCamera(tag, setCamera)
    end,
    --var.endlessLoopSprite 
    setSpriteLooped = function (tag, name, frames, fps, loop, forced, reverse)
        addAnimation(tag, name, frames, fps, loop)
        playAnim(tag, name, forced, reverse, 0)
    end,
    --var.rng()
    rng = function ()
        tostring(math.random())
    end
}