package game;

import assets.GraphicsLibrary;
import sphaeraGravita.math.Vector2D;
import sphaeraGravita.shapes.Polygon;
/**
 * ...
 * @author Dmitriy Barabanschikov
 */
class Wall extends GameEntity
{
	
	public function new() 
	{
		super(); 
		healthPoints = 100;
		
		type = EntityType.FORTIFICATION;
		
		collisionCategory = CollisionCategory.FORTIFICATIONS;
		collisionMask = CollisionCategory.ENEMIES;
		
		var shape:Polygon = new Polygon();
		shape.setPoly([new Vector2D(0, 0), new Vector2D(136, 0), new Vector2D(28, 480), new Vector2D(-20, 480)]);
		addShape(shape);
		init();
		
		graphicsAsset = GraphicsLibrary.getWallAsset();
	}
	
	override public function recieveDamage(damageAmount:Int, damageType:String):Void 
	{
		super.recieveDamage(damageAmount, damageType);
		if (healthPoints < 0) 
		{
			healthPoints = 0;
			disableShapes();
			frameRectNum = 3;
		}
		else
		{
			frameRectNum = Std.int((100 - healthPoints) / 34);
		}
	}
	
	
}