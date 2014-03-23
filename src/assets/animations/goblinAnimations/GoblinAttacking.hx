package assets.animations.goblinAnimations;
import assets.animations.AnimationAsset;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class GoblinAttacking extends AnimationAsset
{
	
	public function new() 
	{
		super();
		looping = false;
		fillFrameRects(0, 1, 16);
	}
	
}