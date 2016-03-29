
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

MainScene.RESOURCE_FILENAME = "MainScene.csb"

function MainScene:onCreate()
    printf("resource node = %s", tostring(self:getResourceNode()))
    self.bullets = {}
    self.streaks = {}
    
end

function MainScene:update(delta)
    -- body
    for k, v in pairs(self.bullets) do
        --todo
        local x, y = v:getPosition()
        local angle = v:getRotation()

        local speed = 20
        local delx = math.sin(angle * math.pi / 180) * speed
        local dely = math.cos(angle * math.pi / 180) * speed
        local ishit = false
        for k1, v1 in pairs(GameManager:getInstance().scene.enermies) do
            ishit = false
            if (x >= v1.tankview:getPositionX() - v1.tankview:getContentSize().width / 2 and
                x <= v1.tankview:getPositionX() + v1.tankview:getContentSize().width / 2) and
                (y >= v1.tankview:getPositionY() - v1.tankview:getContentSize().height / 2 and
                y <= v1.tankview:getPositionY() + v1.tankview:getContentSize().height / 2) then

                self.bullets[k]:removeSelf()
                self.streaks[k]:removeSelf()
                table.remove(self.bullets, k)
                table.remove(self.streaks, k)

                local effect1 = cc.ParticleExplosion:create()
                effect1:setAutoRemoveOnFinish(true)
                effect1:setSpeed(1);
                effect1:setSpeedVar(3);
                -- effect1:setRadialAccel(2);  
                -- effect1:setRadialAccelVar(3);
                -- effect1:setAngle(0);  
                -- effect1:setAngleVar(360); 
                effect1:setDuration(0.01)
                effect1:setEndColor(cc.c3b(255, 255, 255));
                effect1:setTexture(cc.TextureCache:sharedTextureCache():addImage("blomb.png"))
                effect1:setPosition(x, y)
                effect1:addTo(self)
                ishit = true
            end
        end
        if ishit ~= true then
            v:setPosition(x + delx, y + dely)
            self.streaks[k]:setPosition(v:getPosition())
        end
    end
    for k, v in pairs(self.bullets) do
        --todo
        local x, y = v:getPosition()
        if x < 0 or x >= 640 or y < 0 or y >= 960 then
            self.bullets[k]:removeSelf()
            self.streaks[k]:removeSelf()
            table.remove(self.bullets, k)
            table.remove(self.streaks, k)
        end
    end
end

function MainScene:CreateBullet(s_pos_x, s_pos_y, angle)
    local effect = cc.ParticleFire:create()
    effect:setAutoRemoveOnFinish(true)
    effect:setDuration(0.04)
    effect:setSpeed(5);
    effect:setAngle(0);  
    effect:setAngleVar(360);  
    effect:setTexture(cc.TextureCache:sharedTextureCache():addImage("fire_star.png"))
    effect:setPosition(s_pos_x, s_pos_y)
    effect:addTo(self)


    -- local effect1 = cc.ParticleExplosion:create()
    -- effect1:setAutoRemoveOnFinish(true)
    -- effect1:setSpeed(1);
    -- effect1:setSpeedVar(3);
    -- effect1:setRadialAccel(2);  
    -- effect1:setRadialAccelVar(3);
    -- effect1:setAngle(0);  
    -- effect1:setAngleVar(360); 
    -- effect1:setDuration(0.1)
    -- -- effect1:setStartColor(cc.c3b(255, 187, 51));
    -- effect1:setEndColor(cc.c3b(255, 255, 255));
    -- effect1:setTexture(cc.TextureCache:sharedTextureCache():addImage("blomb.png"))
    -- effect1:setPosition(400, 600)
    -- effect1:addTo(self)

    -- 创建子弹
    local bullet = display.newSprite("bullet2.png")
    -- bullet:setAnchorPoint(cc.p(0.5, 0))
    bullet:setRotation(angle)
    bullet:setPosition(s_pos_x, s_pos_y)
    bullet:addTo(self)
    table.insert(self.bullets, bullet)

    -- 添加子弹拖尾特效
    local streak = cc.MotionStreak:create(0.3, 1, 10, cc.c3b(255, 255, 255), "bullet2.png")
    -- streak:setAnchorPoint(cc.p(0.5, 1))
    streak:setPosition(s_pos_x, s_pos_y)
    streak:addTo(self)
    table.insert(self.streaks, streak)
end

return MainScene
