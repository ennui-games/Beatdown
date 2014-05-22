  -----------------------                 +  +
  --Beach Bum Beatdown.--                 0000
  -----------------------                 0000

--Pixel Graphics Beat'em'up Extravaganza--
-- art and game design                  --
--          ennui                       --
-- featuring music from                 --
--          hero dynamic                --
-- soundFX by                           ==
--          thugonaut                   --
--                           2014.05.15 ==
-----------------=--=--=--=--=--=-=-=-====+  +

--some defines, off of the codeface!
drawDebugShit = true
camLimitX = 50
playerHitboxX = 30
playerHitboxY = 100
enemyHitboxX = 30
enemyHitboxY = 100

--require "Scripts/Player.lua"

scene = PhysicsScene2D(1.0, 30)
scene:getDefaultCamera():setOrthoSize(320, 200)

backdrop = SceneImage("Resources/sky.png")
scene:addChild(backdrop)

ground = SceneImage("Resources/ground.png")
ground:setPosition(0, -60.5)
scene:addChild(ground)

ground1 = SceneImage("Resources/ground.png")
ground1:setPosition(320, -60.5)
scene:addChild(ground1)

enemy = SceneSprite("Resources/tone.sprite")
enemy:setPosition(120, 0)
scene:addChild(enemy)
enemy.ownsChildren = true
hitbox = ScenePrimitive( ScenePrimitive.TYPE_VPLANE, enemyHitboxX, enemyHitboxY )
if drawDebugShit == true then
	hitbox:setColor( 0.5, 0.1, 0.1, 1.0 )
	hitbox.backfaceCulled = false
	hitbox.blendingMode = Renderer.BLEND_MODE_MULTIPLY
else
	hitbox.visible = false
end
enemy:addChild(hitbox)
enemy:playAnimation("idle", 0, false)

--player initialisation
player = SceneSprite("Resources/Hobo.sprite")
scene:addChild(player)
player:playAnimation("idle", 0, false)
player.backfaceCulled = false
player.ownsChildren = true
hitbox = ScenePrimitive( ScenePrimitive.TYPE_VPLANE, playerHitboxX, playerHitboxY )
if drawDebugShit == true then
	hitbox:setColor( 0.1, 0.5, 0.1, 1.0 )
	hitbox.backfaceCulled = false
	hitbox.blendingMode = Renderer.BLEND_MODE_MULTIPLY
else
	hitbox.visible = false
end
player:addChild(hitbox)
attackbox = ScenePrimitive( ScenePrimitive.TYPE_VPLANE, 1, 1 )
player:addChild(attackbox)
	attackbox:setColor( 0.1, 0.1, 0.5, 1.0 )

function onKeyDown(key)
	if key == KEY_UP then
		player:playAnimation("lightPunch", 0, true)
		player:attackbox:setPrimitiveOptions( ScenePrimitive.TYPE_VPLANE, 100, 100 )
	elseif key == KEY_RIGHT then
		player:setScaleX(1)
	elseif key == KEY_LEFT then
		player:setScaleX(-1)
	end
end

-- MAY.15.2014: we are introduced to camLimitX the magic number of the stars. tweak it above!
-- this hack intended as a give to a long running dispute with code professionalism.
-- keeep it positive!
function Update(elapsed)
	-- if the player is pressing the right key then scroll the screen
	if Services.Input:getKeyState(KEY_RIGHT) == true then
		if player:getPosition().x <= camLimitX then
			player:setPositionX( player:getPosition().x +3 )
		else
			ground:setPositionX( ground:getPosition().x -3 )
			ground1:setPositionX( ground1:getPosition().x - 3 )
			enemy:setPositionX( enemy:getPosition().x - 3 )
		end
	-- if the player is pressing the left key then move the player
	elseif Services.Input:getKeyState(KEY_LEFT) == true then
		player:setPositionX( player:getPosition().x -3 )
	end

	-- if the player is at the left edge of the screen then stop them
	if player:getPosition().x <= -140 then
		player:setPositionX(-140)
	end

	--if a ground panel is offscreen to the left, put it ahead of the other one
	if ground:getPosition().x <= -320 then
		ground:setPositionX(ground1:getPosition().x + 320)
	elseif ground1:getPosition().x <= -320 then
		ground1:setPositionX(ground:getPosition().x + 320)
	end
end
