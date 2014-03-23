package game;

import game.GameEntity;
/**
 * ...
 * @author Dmitriy Barabanschikov
 */
class Enemy extends AnimatedGameEntity
{
	private var falling:Bool;
	
	public function Enemy() 
	{
		collisionCategory = CollisionCategory.ENEMIES;
		collisionMask = CollisionCategory.SPELLS | CollisionCategory.FORTIFICATIONS;
	}
	
	override public function update():Void 
	{
		super.update();
	}
	
}