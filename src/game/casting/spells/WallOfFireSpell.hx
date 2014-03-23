package game.casting.spells;
import game.casting.spells.CastAgent;
import game.casting.spells.wallOfFireAssets.WallOfFireCastAgent;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class WallOfFireSpell extends SpellBase
{

	public function new() 
	{
		super();
	}
	
	override public function getCastAgent():CastAgent 
	{
		return new WallOfFireCastAgent();
	}
	
}