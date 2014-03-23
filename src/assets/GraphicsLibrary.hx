package assets;

import assets.EntityGraphicsAsset;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Tilesheet;
import nme.geom.Matrix;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.Assets;
/**
 * ...
 * @author Dmitriy Barabanschikov
 */
class GraphicsLibrary
{
	static private var goblinAsset:EntityGraphicsAsset;
	static private var backgroundAsset:EntityGraphicsAsset;
	static private var groundAsset:EntityGraphicsAsset;
	static private var meteorReticleAsset:EntityGraphicsAsset;
	static private var meteorAsset:EntityGraphicsAsset;
	static private var explosionAsset:EntityGraphicsAsset;
	static private var smokeTrailAsset:EntityGraphicsAsset;
	static private var wallAsset:EntityGraphicsAsset;
	static private var flameAsset:EntityGraphicsAsset;
	static private var flameParticleAsset:EntityGraphicsAsset;
	
	static public var palisadeAsset:EntityGraphicsAsset;
	
	#if cpp
	static public var tilesheet:Tilesheet;
	#end
	
	public function GraphicsLibrary() 
	{
		
	}
	
	public static function initialize():Void
	{
		var sourceSheet:BitmapData = Assets.getBitmapData("assets/Tilesheet.png", false);
		
		var sourceXML:Xml = Xml.parse(Assets.getText("assets/Tilesheet.xml"));
		
		var xmlParser:TilesheetXMLParser = new TilesheetXMLParser(sourceXML);
		
		goblinAsset = new EntityGraphicsAsset("goblin").initializeFromVerticalStripe(sourceSheet, xmlParser.getSpriteDescription("monsters/Goblin"), 10);
		goblinAsset.sizeCorrection = new Point( -24, -48);
		
		meteorReticleAsset = new EntityGraphicsAsset("meteorReticle").initializeFromHorizontalStripe(sourceSheet, xmlParser.getSpriteDescription("spells/meteors/Reticle"), 5);
		meteorReticleAsset.sizeCorrection = new Point( -48, -24);
		
		backgroundAsset = new EntityGraphicsAsset("background").initializeFromRegion(sourceSheet, xmlParser.getSpriteDescription("background/Background"));
		groundAsset = new EntityGraphicsAsset("ground").initializeFromRegion(sourceSheet, xmlParser.getSpriteDescription("background/BackgroundFront"));
		
		meteorAsset = new EntityGraphicsAsset("meteor").initializeFromRegion(sourceSheet, xmlParser.getSpriteDescription("spells/meteors/MeteorStraight"));
		meteorAsset.sizeCorrection = new Point( -18, -80);
		
		explosionAsset = new EntityGraphicsAsset("explosion").initializeFromHorizontalStripe(sourceSheet, xmlParser.getSpriteDescription("spells/meteors/Explosion"), 10);
		explosionAsset.sizeCorrection = new Point( -48, -104);
		
		smokeTrailAsset = new EntityGraphicsAsset("smokeTrail").initializeFromVerticalStripe(sourceSheet, xmlParser.getSpriteDescription("spells/meteors/SmokeTrail"), 5);
		smokeTrailAsset.sizeCorrection = new Point( -32, -32);
		
		flameAsset = new EntityGraphicsAsset("flame").initializeFromHorizontalStripe(sourceSheet, xmlParser.getSpriteDescription("spells/wallOfFire/Flame"), 4);
		flameAsset.sizeCorrection = new Point(-32, -80);
		
		wallAsset = new EntityGraphicsAsset("wall").initializeFromHorizontalStripe(sourceSheet, xmlParser.getSpriteDescription("fortifications/Wall"), 4);
		wallAsset.sizeCorrection = new Point( -40, -116);
		
		palisadeAsset = new EntityGraphicsAsset("palisade").initializeFromHorizontalStripe(sourceSheet, xmlParser.getSpriteDescription("fortifications/Palisade"), 3);
		palisadeAsset.sizeCorrection = new Point(0, -48);
		
		flameParticleAsset = new EntityGraphicsAsset("flameParticle").initializeFromRegion(sourceSheet, xmlParser.getSpriteDescription("spells/wallOfFire/FlameParticle"));
		flameParticleAsset.sizeCorrection = new Point(-1, -1);
		
		#if cpp
		createTilesheet(sourceSheet, [goblinAsset, meteorAsset, meteorReticleAsset, backgroundAsset, groundAsset, explosionAsset, smokeTrailAsset, flameAsset, wallAsset, palisadeAsset, flameParticleAsset]);
		#end
	}
	
	#if cpp
	static private function createTilesheet(sourceSheet:BitmapData, assetArray:Array<EntityGraphicsAsset>):Void
	{
		var maxHeight:Float = 0;
		var totalWidth:Float = 0;
		var assetFrameID:Int = 0;
		
		tilesheet = new Tilesheet(sourceSheet);
		
		for (i in 0...assetArray.length)
		{
			var asset:EntityGraphicsAsset = assetArray[i];
			
			for (j in 0...asset.frameRectangles.length) 
			{
				asset.tileSheetFrameID.push(assetFrameID);
				var tilesheetRect:Rectangle = asset.frameRectangles[j].clone();
				tilesheetRect.x += totalWidth;
				asset.tileSheetRectangles.push(tilesheetRect);
				assetFrameID++;
				tilesheet.addTileRect(tilesheetRect);
			}
		}
	}
	#end
	
	static public function getGoblin():EntityGraphicsAsset
	{
		return goblinAsset;
	}
	
	static public function getBackground():EntityGraphicsAsset
	{
		return backgroundAsset;
	}
	
	static public function getGround():EntityGraphicsAsset
	{
		return groundAsset;
	}
	
	static public function getMeteorReticle():EntityGraphicsAsset
	{
		return meteorReticleAsset;
	}
	
	static public function getMeteor():EntityGraphicsAsset
	{
		return meteorAsset;
	}
	
	static public function getExplosion():EntityGraphicsAsset
	{
		return explosionAsset;
	}
	
	static public function getMeteorSmokeTrail():EntityGraphicsAsset
	{
		return smokeTrailAsset;
	}
	
	static public function getWallAsset():EntityGraphicsAsset
	{
		return wallAsset;
	}
	
	static public function getPalisadeAsset():EntityGraphicsAsset
	{
		return palisadeAsset;
	}
	
	static public function getFlameAsset():EntityGraphicsAsset
	{
		return flameAsset;
	}
	
	static public function getFlameParticleAsset():EntityGraphicsAsset
	{
		return flameParticleAsset;
	}
	
}