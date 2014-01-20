How do I create a Weapon?
====================================
  1.  This is general template of a weapon, we shall use Singleshot as our example.  Please take a look at the `init` function.  All fields that are needed for the weapon to function are initialized here.
  2. Make sure to read the comments in `Weapon.lua` before continuing making a weapon, you might be able to make a new weapon by modifying the parameters of an existing weapon.  Take a look at the file `Shop.lua` in `com/equipmenu/`.
  3. There is a hidden field for every weapon called `targets` that holds all the haters on screen.  You cannot access this field in the `init` function, you can only access it in the `fire` function.
  3. The fire function is the **HEART** of how weapons work.  Here is a standard template of how weapons work:
  
            function Singleshot:fire()
                self.super:fire()
                if not self:canFire() then return false end
	                local bullet = self:getNextShot()

	                if bullet then  --you are allowed to shoot

				    local rotationAngle = math.rad(self.owner.sprite.rotation)
				    self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
				    local bulletVelocity = self:calculateBulletVelocity(bullet, self.owner)
				    bullet:fire(bulletVelocity.x, bulletVelocity.y)
				    if self.isPlayerOwned == true then
					    self:playFiringSound()
				    end
	            end	
                return true
            end
Fire is called every frame, since we do not want to fire a bullet every frame, we declare:
            if not self:canFire() then return false end 
                local bullet = self:getNextShot()
What this does is that it fetches a bullet for us to use when it is time for our gun to fire.

    `self:calibrateMuzzleLocation` is a function that is created in our base class `Weapon`.  This makes sure later that bullets are spawned relative to where the tip of the gun should be.
`calibrateBulletVelocity` is used to rotate the bullet relative to where the gun is.   

    `self:calibrateMuzzleLocation` should always be called before `self:calibrateBulletVelocity`.  If you are interested on how the math works.  Please refer to this link: <http://mathworld.wolfram.com/RotationMatrix.html>
    
    `bullet:fire(bulletVelocity.x, bulletVelocity.y)` launches the bullet in `bulletVelocity.x` and `bulletVelocity.y` where `bulletVelocity` is a vector.  For more informaton about vectors, please refer to this: http://www.youtube.com/watch?v=127MpSs0ZkY
    
What if I want make my own update function for my bullet? I hate physics!
---------------
1. That has nothing to do with weapons actually in our system. You will need to make your own specialized bullet.
2. Since all weapons call the bullets `fire` function, we must override the `fire` function for our new bullet.  The general construction for the `fire` function looks like:
        function SuperCoolBullet:fire(bulletVelX, bulletVelY)
            local update = function()
                        end
            Runtime:addEventListener("enterFrame", update)
            self.alive = true
            self.update = update
        end
So what this does is that is that it creates a function called 'update' that gets called every frame when Corona calls its update event.  Any variables defined outside of update can be passed into our new update function.  **Remember to remove the event listener in your `recycle` function so that there are no memory leaks.**  An example of this should look like this:
        function SuperCoolBullet:recycle()
            Runtime:removeEventListener("enterFrame", self.update)
            self.super:recycle(self)
        end

    *Ex:* Take a look at `HomingBullet` or `SineWaveBullet` in `com/game/weapons` for a reference.
    
How do I get a reference to the all the haters on the screen?
------------------------------------------------------------
All weapons are equipped with a `targets` variable that is a table
that holds all the haters on screen.  You can retrieve this by using `self.targets`.  Note, this variable is not avialable in the `init` function because weapons get created outside of the game.  Give your bullets a reference to the the `targets` variable before your fire your bullet.

*Ex:* See `Homingshot:fire` for a reference.

How do I get a reference to the player in my weapon?
-----------------------------------------------------
All weapons have a reference to the player called `player`.  You can retrieve this by using `self.player`.  Note, this variable is not avialable in the `init` function because weapons get created outside of the game.  Give your bullets a reference to `player` if you need information about the player.
    