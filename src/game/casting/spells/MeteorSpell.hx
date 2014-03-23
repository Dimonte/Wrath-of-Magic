package game.casting.spells;
import game.casting.spells.CastAgent;
import game.casting.spells.meteorAssets.MeteorCastAgent;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class MeteorSpell extends SpellBase
{

	public function new() 
	{
		super();
	}
	
	override public function getCastAgent():CastAgent 
	{
		return new MeteorCastAgent();
	}
	
}