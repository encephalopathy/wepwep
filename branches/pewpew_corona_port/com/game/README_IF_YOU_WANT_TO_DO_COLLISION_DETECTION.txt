HOW TO DO COLLISION DETECTION:

The numbers and labels below are category bit ids for every moveable object(Haters, Players, options, etc).  
Category bits and masks are used to determine which object should collide with one another.  We use category bits 
because it is the most optimal way to do collision detection in Box2D.  Category bits are created as powers of two, an object's 
category mask should be the sum of ALL OTHER objects category bits that the object can collide with. 
If this sounds very confusing, see this link as a reference: 
http://developer.coronalabs.com/forum/2010/10/25/collision-filters-helper-chart

EX.
Player collision flag: 1
It can collide with Haters, enemy bullets, and collectibles. Hence it's collision mask is
Player's category mask: 2 + 8 + 16  = 26

A category mask in our code base is called "maskBits".

------CATEGORY BITS------
	PLAYER: 1
	HATER: 2 
	PLAYER BULLET: 4
	ENEMY BULLET: 8
	COLLECTIBLE: 16

NOTE: Please add your collision flag changes when you are done.