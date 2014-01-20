How do I make the player equip the weapon/passive I made?
=====================================================

1. Open up the file `Shop.lua` located in `com/equipmenu/Shop.lua.`
2. Look for the `init` function in `Shop.lua` you will see something that looks like:

        self.Weapons = {}

        self.Weapons['com/resources/art/sprites/shop_splash_images/SingleShot.png'] = { item = Singleshot:new(scene, true, 25, 200, 0, 0), dollaz = 40 }
        self.Weapons['com/resources/art/sprites/shop_splash_images/SpreadShot.png'] = { item = Spreadshot:new(scene, true, 35, 200, 0, 0, nil, nil, nil, nil, nil, nil, 4, 15, 4, 15), dollaz = 500 }
        self.Weapons['com/resources/art/sprites/shop_splash_images/Sinewave.png'] = { item = SineWave:new(scene, true, 25, 200), dollaz = 50 }
        self.Weapons['com/resources/art/sprites/shop_splash_images/HomingShot.png'] = { item = Homingshot:new(scene, true, 35, 200), dollaz = 100 }
        self.Weapons['com/resources/art/sprites/shop_splash_images/DoubleShot.png'] = { item = Doubleshot:new(scene, true, 25, 200, 0, 0), dollaz = 70 }
        self.Weapons['com/resources/art/sprities/shop_splash_images/BackShot.png'] = { item = Backshot:new(scene, true), dollaz = 80 }
   
        self.permission = {}

        self.permission[1] = true
        self.permission[2] = false
        self.permission[3] = false
        self.permission[4] = false
        self.permission[5] = false
        self.permission[6] = false

    These are the primary weapons that the player can equip above. you will notice that `permissions` value at location one is set to true because that is the weapon the player currently has equipped.  The `Weapons` table stores all the primary weapons the player can use.  **So to create a new primary weapon**, create an entry in the `Weapons` table.  The key value of that table should be a splash image to signify what weapon it is in the equip menu.  The value is another table that holds the reference of the weapon and the amount of dollaz it costs to equip that weapon.

3. To create secondary weapons and passives, you will see two functions `Shop:createSecondaryWeapons` and `Shop:createPassives` below it.  Put your respective secondary item into the appropriate folder.
4. Open up the `MenuEquip.lua`, it should be located in the same folder as `Shop.lua`, look for a variable called `primaryWeapsSplashImages` and add the splash image that matches the weapon you added if you made a primary weapon. Otherwise do the same but for `secondarySplashImages` for passives and secondary weapons.
