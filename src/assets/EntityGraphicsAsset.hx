package assets;

import nme.Assets;
import nme.display.BitmapData;
import nme.geom.Matrix;
import nme.geom.Point;
import nme.geom.Rectangle;
/**
 * ...
 * @author Dmitriy Barabanschikov
 */
class EntityGraphicsAsset
{
	
	public var spriteSheet:BitmapData;
	public var frameRectangles:Array<Rectangle>;
	public var tileSheetRectangles:Array<Rectangle>;
	public var tileSheetFrameID:Array<Int>;
	public var sizeCorrection:Point;
	public var assetFrameByName:Map<String,Int>;
	
	public function new(assetID:String)
	{
		frameRectangles = new Array();
		tileSheetFrameID = new Array();
		tileSheetRectangles = new Array();
		assetFrameByName = new Map<String,Int>();
	}
	
	public function initializeFromAssetNames(namesArray:Array<String>):EntityGraphicsAsset
	{
		var sourceAssets:Array<BitmapData> = [];
		var numAssets:Int = namesArray.length;
		var maxWidth:Int = 0;
		var maxHeight:Int = 0;
		for (i in 0...numAssets)
		{
			//trace(namesArray[i]);
			var asset:BitmapData = Assets.getBitmapData(namesArray[i]);
			maxWidth = Std.int(Math.max(maxWidth, asset.width));
			maxHeight = Std.int(Math.max(maxHeight, asset.height));
			sourceAssets.push(asset);
			assetFrameByName.set(namesArray[i], i);
		}
		
		//TODO only for non-flash targets
		#if (!flash)
		maxWidth = Math.ceil(Std.int(Math.max(maxWidth, maxHeight))/2)*2;
		maxHeight = maxWidth;
		#end
		
		sizeCorrection = new Point(-maxWidth / 2, -maxHeight/2);
		
		frameRectangles = new Array();
		
		#if flash
		spriteSheet = new BitmapData(numAssets * maxWidth, numAssets*maxHeight, true, 0x0);
		#else
		spriteSheet = new BitmapData(numAssets * maxWidth, numAssets*maxHeight, true, 0x0);
		#end
		
		for (i in 0...numAssets)
		{
			var destinationRectangle:Rectangle = new Rectangle(i * maxWidth, 0, maxWidth, maxHeight);
			//trace(destinationRectangle);
			frameRectangles.push(destinationRectangle);
			var sourceWidth:Int = sourceAssets[i].width;
			var sourceHeight:Int = sourceAssets[i].height;
			spriteSheet.copyPixels(sourceAssets[i], new Rectangle(0, 0, sourceWidth, sourceHeight), new Point(destinationRectangle.x + Std.int((maxWidth - sourceWidth) / 2), destinationRectangle.y + Std.int((maxHeight - sourceHeight) / 2)));
		}
		
		return this;
	}
	
	public function getFrameByAssetName(assetName:String):Int
	{
		var assetFrame:Null<Int> = assetFrameByName.get(assetName);
		if (assetFrame != null) 
		{
			return assetFrame;
		}
		return 0;
	}
	
	public function clear() 
	{
		spriteSheet.dispose();
	}
	
	public function initializeFromRegion(spriteSheet:BitmapData, spriteDescription:SpriteDescription):EntityGraphicsAsset
	{
		this.spriteSheet = spriteSheet;
		frameRectangles = new Array();
		frameRectangles.push(new Rectangle(spriteDescription.x, spriteDescription.y, spriteDescription.width, spriteDescription.height));
		return this;
	}
	
	public function initializeFromVerticalStripe(spriteSheet:BitmapData, spriteDescription:SpriteDescription, numFrames:Int):EntityGraphicsAsset
	{
		this.spriteSheet = spriteSheet;
		frameRectangles = new Array();
		
		var tileHeight:Float = Std.int(spriteDescription.height / numFrames);
		
		for (i in 0...numFrames) 
		{
			frameRectangles.push(new Rectangle(spriteDescription.x, spriteDescription.y + tileHeight * i, spriteDescription.width, tileHeight));
		}
		
		return this;
	}
	
	public function initializeFromHorizontalStripe(spriteSheet:BitmapData, spriteDescription:SpriteDescription, numFrames:Int):EntityGraphicsAsset
	{
		this.spriteSheet = spriteSheet;
		frameRectangles = new Array();
		
		var tileWidth:Float = Std.int(spriteDescription.width / numFrames);
		
		for (i in 0...numFrames) 
		{
			frameRectangles.push(new Rectangle(spriteDescription.x + tileWidth*i, spriteDescription.y, tileWidth, spriteDescription.height));
		}
		return this;
	}
	
	public function getBitmapDataForFrame(frameNum:Int):BitmapData
	{
		var frameRect:Rectangle = frameRectangles[frameNum];
		var bitmapData:BitmapData = new BitmapData(Std.int(frameRect.width), Std.int(frameRect.height), true, 0);
		bitmapData.copyPixels(spriteSheet, frameRect, new Point(0, 0));
		return bitmapData;
	}
	
}