package game.casting.spells.meteorAssets;
import sphaeraGravita.math.Vector2D;
import sphaeraGravita.shapes.BaseShape;
import assets.GraphicsLibrary;
import game.CollisionCategory;
import game.GameEntity;
import sphaeraGravita.collision.PhysicalBody;
import sphaeraGravita.shapes.CircleShape;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class Explosion extends GameEntity
{
	private var i:Int;
	private var force:Float;

	public function new() 
	{
		super();
		
		force = 40;
		
		graphicsAsset = GraphicsLibrary.getExplosion();
		
		var shape:CircleShape = new CircleShape(0,0,64);
		addShape(shape);
		
		collisionCategory = CollisionCategory.SPELLS;
		collisionMask = CollisionCategory.ENEMIES;
		
		init();
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (i == 0) 
		{
			var collider:GameEntity;
			for (collisionToken in collisionList) 
			{
				collider = cast(collisionToken.collidingBody, GameEntity);
				collider.recieveDamage(Std.int(Math.random() * 70 + 30), "");
				
				var pushVector:Vector2D = new Vector2D(collider.position.x - position.x, collider.position.y - position.y).normalize();
				
				collider.push(pushVector.x * force, pushVector.y * force, force);
			}
		}
		
		
		
		frameRectNum = Std.int(i / 3);
		//frameRectNum = 0;
		i++;
		if (i > 30) 
		{
			dead = true;
		}
		
		
	}
	
	
}