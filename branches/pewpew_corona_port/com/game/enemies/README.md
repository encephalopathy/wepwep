 How do I create a Hater?
===========================
   1. Copy Paste the file at this location to be your new hater:
        `pewpew_corona_port/com/game/enemies/Hater.lua`.  MAKE SURE YOU PASTE YOUR NEW FILE INTO THE `enemies` folder.
   2.  Make sure that your new Hater is a subclass of Hater.lua.  See the above, **WTF IS UP WITH THIS FANCY LUA CLASS SYNTAX?!** for more information.
   3. Look for a function called `init`.  This gets called when the hater get's created for the first time.  You will then see a function that looks like `self.super:init`, make sure the parameters of that init call match the parameters of your parent class's `init`.
   4. You will see a function called `Hater:update`, `Hater:update` gets updated every frame so all game logic for the hater that you are making goes there.
   5. `Hater:respawn` gets called if the particular hater gets grabbed off-screen and put on-screen.  All values and attributes that need to be reset in order for the hater to function should be set here.
    * ex: `self.heatlh = self.maxHealth`
      *We wouldn't want the hater to die when they enter screen!*
   6. `Hater:destroy` is the destructor that gets called when the player leaves game.  Make sure you de-reference all table values!

**How do I create a Carrier?**
-------------------------------------------------------------------------
