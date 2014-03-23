package assets.animations.goblinAnimations;

import assets.animations.AnimationAsset;
/**
 * ...
 * @author Dmitriy Barabanschikov
 */
class GoblinDying extends AnimationAsset
{
	
	public function new() 
	{
		super();
		looping = false;
		fillFrameRects(6, 9, 8);
	}
	
}