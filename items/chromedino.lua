

SMODS.Sound({key = "dino_jump", path = "dino_jump.ogg",})
SMODS.Sound({key = "dino_death", path = "dino_death.ogg",})

dinoLoad = function()
    if not G.dino then
        Yahimod.img_dino = loadThatFuckingImage("chromedino.png")
        Yahimod.spr_dino = loadThatFuckingImageSpritesheet("chromedino.png",98,100,6,1) 

        

        

        local _xscale = love.graphics.getWidth()/1920
        local _yscale = love.graphics.getHeight()/1080

        G.dino = {}

        G.dino.cacw = 42*2
        G.dino.cach = 76*2

        G.dino.cachbox_x = 10
        G.dino.cachbox_y = 25
        G.dino.cachbox_w = 66
        G.dino.cachbox_h = 124

        Yahimod.img_cactus = loadThatFuckingImage("chromedino_cactus.png")
        Yahimod.spr_cactus = loadThatFuckingImageSpritesheet("chromedino_cactus.png",G.dino.cacw,G.dino.cach,5,1)

        G.dino.cacw = G.dino.cacw*_xscale
        G.dino.cach = G.dino.cach*_yscale
        
        G.dino.x = 523*_xscale
        G.dino.y = 291*_yscale

        G.dino.w = 98*_xscale
        G.dino.h = 100*_yscale

        G.dino.yvel = 0
        G.dino.obstacles = {}

        G.dino.gamefloory = 400*_xscale
        G.dino.gameceily = 0*_yscale

        G.dino.firsttick = Yahimod.ticks
    end
end

dinoTick = function()
    if G.dino and not G.SETTINGS.paused then
        local _yscale = love.graphics.getHeight()/1080

        if math.fmod(Yahimod.ticks,220) == 0 then
            dinoSpawnObstacle()
        end

        if G.dino.y < G.dino.gameceily then G.dino.y = G.dino.gameceily end
        if G.dino.y > G.dino.gamefloory then 
            G.dino.y = G.dino.gamefloory 
            G.dino.yvel = 0 end
        if G.dino.y < G.dino.gamefloory then G.dino.yvel = G.dino.yvel + (0.25 * _yscale) end

        G.dino.y = G.dino.y + G.dino.yvel

        for i = 1, #G.dino.obstacles do
            if G.dino and G.dino.obstacles[i] then
                local _ob = G.dino.obstacles[i]
                _ob.obsx = _ob.obsx + _ob.obsxvel
                if _ob.obsx < 0 then table.remove(G.dino.obstacles,i) end
                if CheckCollision(G.dino.x, G.dino.y, G.dino.w, G.dino.h,  _ob.obsx+G.dino.cachbox_x, _ob.obsy+G.dino.cachbox_y, G.dino.cachbox_w, G.dino.cachbox_h) then
                    
                    playEffect("explosion",G.dino.x,G.dino.y)
                    print("Game Over!")
                    endDino()
                    
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blocking = false,
                        delay = 2,
                        func = function()
                            play_sound("yahimod_dino_death")
                            forceGameover()
                            return true
                        end,
                        }))
                end
            end
        end
    end
end

dinoSpawnObstacle = function()
    if G.dino and #G.dino.obstacles < 4 then
        local _intensity = math.floor((Yahimod.ticks - G.dino.firsttick)/2000 )
        local _xscale = love.graphics.getWidth()/1920
        local _yscale = love.graphics.getHeight()/1080

        local _obs = {
            obsx = love.graphics.getWidth() + 200,
            obsy = G.dino.gamefloory - G.dino.cach*0.5+(28*_yscale),
            obsframe = math.random(1,5),
            
            obsxvel = -5 + _intensity*-1 * _xscale ,
        }
        table.insert(G.dino.obstacles,_obs)
    end
end

dinoDraw = function()

    local _xscale = love.graphics.getWidth()/1920
    local _yscale = love.graphics.getHeight()/1080

    if G.dino and not G.SETTINGS.paused then
        love.graphics.setColor(1, 1, 1, 1) 
        local _frame = 1+ math.floor(math.fmod(Yahimod.ticks/25,4))
        love.graphics.draw(Yahimod.img_dino, Yahimod.spr_dino[_frame], G.dino.x, G.dino.y,0,_xscale,_yscale,0,0)

        for i = 1, #G.dino.obstacles do
            local _ob = G.dino.obstacles[i]
            if _ob then love.graphics.draw(Yahimod.img_cactus, Yahimod.spr_cactus[_ob.obsframe], _ob.obsx, _ob.obsy,0,_xscale,_yscale,0,0) end
        end
    end
end

dinoJump = function()
    local _yscale = love.graphics.getHeight()/1080
    if G.dino and G.dino.y == G.dino.gamefloory then
        G.dino.yvel = -11 * _yscale
        play_sound("yahimod_dino_jump")
    end
end

endDino = function()
    G.dino = nil
end