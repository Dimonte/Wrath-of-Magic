package game.casting.spells;
import nme.errors.IllegalOperationError;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class SpellBase 
{
	
	
	public function new() 
	{
		
	}
	
	public function getCastAgent():CastAgent
	{
		throw new IllegalOperationError("This method should be overridden in all subclasses");
		return null;
	}
	
}