package game.casting.spells.wallOfFireAssets;
import assets.GraphicsLibrary;
import game.CollisionCategory;
import game.GameEntity;
import sphaeraGravita.shapes.CircleShape;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class Flame extends GameEntity
{

	private var i:Int;
	private var force:Float;
	private var length:Int;

	public function new() 
	{
		super();
		
		graphicsAsset = GraphicsLibrary.getFlameAsset();
		
		var shape:CircleShape = new CircleShape(0,0,32);
		addShape(shape);
		
		collisionCategory = CollisionCategory.SPELLS;
		collisionMask = CollisionCategory.ENEMIES;
		
		length = 90;
		
		init();
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (i % 2 == 0)
		{
			var collider:GameEntity;
			for (collisionToken in collisionList) 
			{
				collider = cast(collisionToken.collidingBody, GameEntity);
				collider.recieveDamage(Std.int(Math.random() * 2 + 1), "");
			}
		}
		
		
		
		if (i < 4 || i >= length - 4) 
		{
			frameRectNum = 3;
		}
		else if (i < 8 || i >= length - 8) 
		{
			frameRectNum = 2;
		}
		else
		{
			if ((y < 0 || y > 480) && i < length - 4)
			{
				i = length - 4;
				frameRectNum = 3;
			}
			else if (i % 8 > 4) 
			{
				frameRectNum = 0;
			}
			else 
			{
				frameRectNum = 1;
			}
		}
		i++;
		if (i > length) 
		{
			dead = true;
		}
		
		
	}
	
}