package game.casting.spells;
import game.KillingField;
import nme.errors.IllegalOperationError;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class CastAgent 
{
	public var depleted:Bool;

	public function new() 
	{
		
	}
	
	public function applyEffectToWorld(world:KillingField, worldX:Float, worldY:Float):Void
	{
		throw new IllegalOperationError("This method should be overridden in all subclasses");
	}
	
}