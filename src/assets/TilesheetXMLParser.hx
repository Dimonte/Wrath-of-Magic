package assets;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class TilesheetXMLParser 
{
	private var sourceXML:Xml;

	public function new(sourceXML:Xml) 
	{
		this.sourceXML = sourceXML;
	}
	
	public function getSpriteDescription(spriteID:String):SpriteDescription
	{
		var spriteDescription:SpriteDescription = new SpriteDescription();
		
		for (sprite in sourceXML.firstElement().elementsNamed("sprite"))
		{
			if (sprite.get("n") == spriteID)
			{
				SOSLog.sosTrace( "sprite.get(\"n\") : " + sprite.get("n") );
				spriteDescription.x = Std.parseFloat(sprite.get("x"));
				spriteDescription.y = Std.parseFloat(sprite.get("y"));
				spriteDescription.width = Std.parseFloat(sprite.get("w"));
				spriteDescription.height = Std.parseFloat(sprite.get("h"));
				break;
			}
		}
		
		return spriteDescription;
	}
	
}