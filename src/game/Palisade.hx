package game;

import assets.GraphicsLibrary;
import sphaeraGravita.math.Vector2D;
import sphaeraGravita.shapes.Polygon;
/**
 * ...
 * @author Dmitriy Barabanschikov
 */
class Palisade extends GameEntity
{
	
	public function new() 
	{
		super(); 
		healthPoints = 30;
		
		type = EntityType.FORTIFICATION;
		
		collisionCategory = CollisionCategory.FORTIFICATIONS;
		collisionMask = CollisionCategory.ENEMIES;
		
		var shape:Polygon = new Polygon();
		shape.setPoly([new Vector2D(96, 0), new Vector2D(160, 0), new Vector2D(48, 480), new Vector2D(-20, 480)]);
		addShape(shape);
		init();
		
		frameRectNum = 2;
		
		graphicsAsset = GraphicsLibrary.getPalisadeAsset();
	}
	
	override public function recieveDamage(damageAmount:Int, damageType:String):Void 
	{
		super.recieveDamage(damageAmount, damageType);
		if (healthPoints < 0) 
		{
			healthPoints = 0;
			disableShapes();
			frameRectNum = 0;
		}
		else
		{
			frameRectNum = Math.ceil(healthPoints / 15);
		}
	}
	
	
}