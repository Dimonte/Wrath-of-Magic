package assets.animations.goblinAnimations;

import assets.animations.AnimationAsset;
/**
 * ...
 * @author Dmitriy Barabanschikov
 */
class GoblinWalking extends AnimationAsset
{
	
	public function new() 
	{
		super();
		looping = true;
		fillFrameRects(2, 3, 8);
	}
	
}