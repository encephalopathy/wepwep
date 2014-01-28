**Frequently Asked Questions**
=======================

Table of Contents:
==================
* [How do I create a Hater?](https://github.com/encephalopathy/wepwep/tree/master/branches/pewpew_corona_port/com/game/enemies)
* [How do I create a Weapon?](https://github.com/encephalopathy/wepwep/tree/master/branches/pewpew_corona_port/com/game/weapons)
* [How do I add a weapon to the player?](https://github.com/encephalopathy/wepwep/tree/master/branches/pewpew_corona_port/com/equipmenu)
* [How do I use the Level Editor?](https://github.com/encephalopathy/wepwep/tree/master/LevelEditor)
* [How do I add a weapon to a Hater?](https://github.com/encephalopathy/wepwep/tree/master/LevelEditor)
* [How do I make a level?]((https://github.com/encephalopathy/wepwep/tree/master/LevelEditor)

WTF IS UP WITH THIS FANCY LUA CLASS SYNTAX?!
-------------------------------------------------------------------------------------
Given the following lua syntax on the left is equivalent to the java syntax on the right:
*  `self.p00p = 5` == `this.p00p = 5;`.
* `Hater = Ride:subclass("Hater")` == `public class Hater extends Ride`
* `function Hater:init() 
   end` == `public Hater() {  }`
* `require "util.Scanner"` == `import java.util.Scanner;`
* `Hater.static.message = "Sup"` == `Hater.message = "Sup";`
* `Bullet:virtual("update")` == `public abstract void update();` for class Bullet
* `Hater:fire() end` implies `public class Hater { public void fire() { } }`

Overriding rules in lua work the same way in java, except that overridden functions don't have to match the arguments of their base classes.  There is no overloading in our lua class implementation.  Still confused?  Then you should learn some java: <http://www.ntu.edu.sg/home/ehchua/programming/java/J3a_OOPBasics.html>
