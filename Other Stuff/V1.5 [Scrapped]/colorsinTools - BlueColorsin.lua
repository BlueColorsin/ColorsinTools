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
        if checkFileExists("images/"..self.dir..image..'.png') == false then debugPrint(tag..' is a nil image') end
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
    --var.setObjLooped 
    setObjLooped = function (tag, prefix, fps)
        addAnimationByPrefix(tag, prefix, prefix, fps, true)
        playAnim(tag, prefix, true, false, 0)
    end,
    --var.rng()
    rng = function ()
        tostring(math.random())
    end,
    --var:test()
    test = function()
        debugPrint('Colorsin Tools v1.5 Beta \nWip, Yay')
    end,
    --var:flashObj()
    flashObj = function (self,tag, startVal, time, ease)
        setProperty(tag..".alpha", startVal)
        doTweenAlpha(self.rng, tag, 0, time, ease)
    end
}