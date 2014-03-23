package assets.animations;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */
class AnimationAsset
{
	public var looping:Bool;
	public var frames:Array<Int>;
	
	public function new() 
	{
		frames = new Array();
	}
	
	public function fillFrameRects(startFrame:Int, endFrame:Int, keyframeInterval:Int):Void
	{
		var numKeyframes:Int = endFrame - startFrame + 1;
		var numFrames:Int = numKeyframes * keyframeInterval;
		for (i in 0...numFrames) 
		{
			frames[i] = Std.int(i / keyframeInterval) + startFrame;
		}
	}
	
	public function getLength():Int
	{
		return frames.length;
	}
	
	public function getFrameRectNum(animationFrame:Int):Int
	{
		return frames[animationFrame];
	}
	
}