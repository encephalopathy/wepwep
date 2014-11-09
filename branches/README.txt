**Frequently Asked Questions**
=======================
   WTF IS UP WITH THIS FANCY LUA CLASS SYNTAX?!
-------------------------------------------------------------------------------------
1.  Given the following lua syntax on the left is equivalent to the java syntax on the right:
      *  `self.p00p = 5` == `this.p00p = 5;`.
      * `Hater = Ride:subclass("Hater")` == `public class Hater extends Ride`
      * `function Hater:init() 
        end` == `public Hater() {  }`
      * `require "util.Scanner"` == `import java.util.Scanner;`
      * `Hater.static.message = "Sup"` == `Hater.message = "Sup";`
      * `Bullet:virtual("update")` == `public abstract void update();` for class Bullet
      * `Hater:fire() end` implies `public class Hater { public void fire() { } }`

    Overriding rules in lua work the same way in java, except that .  There is no overloading in our lua class implementation.  Still confused?  Then you should learn some java: <http://www.ntu.edu.sg/home/ehchua/programming/java/J3a_OOPBasics.html>

 How do I create a Hater?
----------------------------------------
   1. Copy Paste the file at this location to be your new hater:
        `pewpew_corona_port/com/game/enemies/Hater.lua`.  MAKE SURE YOU PASTE YOUR NEW FILE INTO THE `enemies` folder.
   2.  Make sure that your new Hater is a subclass of Hater.lua.  See the above, **WTF IS UP WITH THIS FANCY LUA CLASS SYNTAX?!** for more information.
   3. Look for a function called `init`.  This gets called when the hater get's created for the first time.  You will then see a function that looks like `self.super:init`, make sure the parameters of that init call match the parameters of your parent class's `init`.
   4. You will see a function called `Hater:update`, `Hater:update` gets updated every frame so all game logic for the hater that you are making goes there.
   5. `Hater:respawn` gets called if the particular hater gets grabbed off-screen and put on-screen.  All values and attributes that need to be reset in order for the hater to function should be set here.
    * ex: `self.heatlh = self.maxHealth`
      *We wouldn't want the hater to die when they enter screen!*
   6. `Hater:destroy` is the destructor that gets called when the player leaves game.  Make sure you de-reference all table values!
   7. **How do I create a Carrier?**
   -------------------------------------------------------------------------

- How do I create a Weapon?
-----------------------------------------------------------
  1.  This is general template of a weapon:
  2.  
  3. 
  **How is it tied to bullets:**
- How do I create a Passive?
------------------------------------------
- How do I make the player equip the weapon I made?
-------------------------------------------------------------------------------
1. Open up the file `Shop.lua` located in `com/equipmenu/Shop.lua.`
2. Look for the `init` function in `Shop.lua` you will see something that looks like: 
1. Open up the file `Shop.lua` located in `com/equipmenu/Shop.lua.`
2. Look for the `init` function in `Shop.lua` you will see something that looks like: 
>1. self.Weapons = {}
>
>2. self.Weapons['com/resources/art/sprites/shop_splash_images/SingleShot.pn
g'] = { item = Singleshot:new(scene, true, 25, 200, 0, 0), dollaz = 40 }
>3. self.Weapons['com/resources/art/sprites/shop_splash_images/SpreadShot.png'] = { item = Spreadshot:new(scene, true, 35, 200, 0, 0, nil, nil, nil, nil, nil, nil, 4, 15, 4, 15), dollaz = 500 }
>4. self.Weapons['com/resources/art/sprites/shop_splash_images/Sinewave.png'] = { item = SineWave:new(scene, true, 25, 200), dollaz = 50 }
>5. self.Weapons['com/resources/art/sprites/shop_splash_images/HomingShot.png'] = { item = Homingshot:new(scene, true, 35, 200), dollaz = 100 }
>6. self.Weapons['com/resources/art/sprites/shop_splash_images/DoubleShot.png'] = { item = Doubleshot:new(scene, true, 25, 200, 0, 0), dollaz = 70 }
>7. self.Weapons['com/resources/art/sprities/shop_splash_images/BackShot.png'] = { item = Backshot:new(scene, true), dollaz = 80 }
>   
>8. self.permission = {}
>
>9. self.permission[1] = true
>10. self.permission[2] = false
>11. self.permission[3] = false
>12. self.permission[4] = false
>13. self.permission[5] = false
>14. self.permission[6] = false

These are the primary weapons that the player can equip above. you will notice that `permissions` value at location one is set to true because that is the weapon the player currently has equipped.  The `Weapons` table stores all the primary weapons the player can use.  **So to create a new primary weapon**, create an entry in the `Weapons` table.  The key value of that table should be a splash image to signify what weapon it is in the equip menu.  The value is another table that holds the reference of the weapon and the amount of dollaz it costs to equip that weapon.
5. To create secondary weapons and passives, you will see two functions `Shop:createSecondaryWeapons` and `Shop:createPassives` below it.  Put your respective secondary item into the appropriate folder.
**6. The reason why we create weapons here is because this gives us the ability to customize how our weapon should operate in one centralized area.**
- How do I make the haters equip the weapon I made?
--------------------------------------------------------------------------------
1. See Level Editor FAQ at this link: 