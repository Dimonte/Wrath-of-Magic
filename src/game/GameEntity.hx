package game;

import assets.EntityGraphicsAsset;
import flash.display.BitmapData;
import flash.geom.Point;
import game.GameEntity;
import sphaeraGravita.collision.CollisionResult;
import sphaeraGravita.collision.PhysicalBody;
import sphaeraGravita.shapes.BaseShape;
/**
 * ...
 * @author Dimonte
 */
class GameEntity extends PhysicalBody
{
	public var type:String;
	public var fieldReference:KillingField;
	public var healthPoints:Int;
	public var unguidedProjectile:Bool;
	public var graphicsAsset:EntityGraphicsAsset;
	public var frameRectNum:Int;
	public var collisionList:Array<CollisionToken>;
	public var altitude:Float;
	public var altSpeed:Float;
	public var collisionsTested:Array<GameEntity>;
	public var world:KillingField;
	public var graphicsAlpha:Float;

	
	public function new() 
	{
		super();
		collisionList = new Array();
		altitude = 0;
		altSpeed = 0;
		graphicsAlpha = 1;
	}
	
	override public function reactToCollision(collidingBody:PhysicalBody, selfShape:BaseShape, otherShape:BaseShape):Void
	{
		collisionList.push(new CollisionToken(collidingBody, selfShape, otherShape));
	}
	
	public function destroy():Void
	{
		dead = true;
	}
	
	public function updateStart():Void
	{
		while (collisionList.length > 0) 
		{
			collisionList.pop();
		}
	}
	
	public function update():Void
	{
		
	}
	
	public function updateEnd():Void
	{
		while (collisionList.length > 0) 
		{
			collisionList.pop();
		}
	}
	
	public function doDamage():Void
	{
		
	}
	
	public function recieveDamage(damageAmount:Int, damageType:String):Void
	{
		healthPoints -= damageAmount;
	}
	
	public function die():Void
	{
		dead = true;
	}
	
	public function push(forceX:Float, forceY:Float, forceZ:Float):Void
	{
		
	}
	
}