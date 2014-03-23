package game;
import assets.animations.AnimationAsset;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */
class AnimatedGameEntity extends GameEntity
{
	public var animationFrame:Int;
	public var _animation:AnimationAsset;
	public var loopCompleteFunction:Void->Void;
	public var animationCompleteFunction:Void->Void;
	public var animation(get_animation, set_animation):AnimationAsset;
	
	public function new() 
	{
		super();
	}
	
	override public function update():Void 
	{
		super.update();
		updateAnimation();
	}
	
	public function updateAnimation():Void
	{
		if (animation == null) 
		{
			return;
		}
		
		if (animationFrame >= _animation.getLength()) 
		{
			if (_animation.looping) 
			{
				animationFrame = 0;
				if (loopCompleteFunction != null) 
				{
					loopCompleteFunction();
				}
			} else 
			{
				animationCompleteFunction();
				return;
			}
		}
		
		frameRectNum = _animation.getFrameRectNum(animationFrame);
		
		animationFrame++;
	}
	
	public function get_animation():AnimationAsset { return _animation; }
	
	public function set_animation(value:AnimationAsset):AnimationAsset 
	{
		if (_animation == value) 
		{
			return _animation;
		}
		_animation = value;
		animationFrame = 0;
		return _animation;
	}
	
}