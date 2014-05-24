module(..., package.seeall)

function AddPlayer()
	hobo = SceneSprite("Resouces/Hobo.sprite")
	hobo:setPosition(0, 0)
	hobo:setScale(1, 1)
	scene:addChild(hobo)
end