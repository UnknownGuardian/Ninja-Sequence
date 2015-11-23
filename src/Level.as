package  
{
	import flash.geom.Point;
	import flash.system.System;
	import flash.utils.getTimer;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Level extends Entity 
	{
		
		
		private static var EncodingVersion:String = "1";
		private static var ExtraData:String = ""
		
		//private var _grid:Grid;
		
		protected var _staticEntity:LevelStaticLayer;
		protected var _collectableEntity:LevelCollectableLayer;
		protected var _glassEntity:LevelGlassLayer;
		protected var _spikeEntity:LevelSpikeLayer;
		
		public static var StaticNumbers:Array = [3, 7, 12, 13];
		public static var CollectableNumbers:Array = [1, 4, 5, 6, 14,15,16,17,18];
		public static var GlassNumbers:Array = [2];
		public static var SpikeNumbers:Array = [8, 9, 10, 11];
		public static var EmptyNumbers:Array = [0];
		
		public var playerLoc:Point;
		public var senseiLoc:Point; 
		
		public function Level() 
		{
			
			_staticEntity = new LevelStaticLayer();
			_collectableEntity = new LevelCollectableLayer();
			_glassEntity = new LevelGlassLayer();
			_spikeEntity = new LevelSpikeLayer();
			
			
			
			//addGraphic(_staticTiles);
			//addGraphic(_collectableTiles);
			//addGraphic(_glassTiles);
			//addGraphic(_spikeTiles);
			
			layer = 40;
			
			
			
			
			//_staticEntity.type = "static";
			//_collectableEntity.type = "collectables";
			//_glassEntity.type = "glass";
			//_spikeEntity.type = "spikes";
		}
		override public function added():void
		{
			world.add(_staticEntity);
			world.add(_collectableEntity);
			world.add(_glassEntity);
			world.add(_spikeEntity);
		}
		
		public function generateCollisionData():void
		{
			//_grid = _tiles.createGrid([1,2,3,7,8,9,10,11,12,13]);// [0, 1, 2, 5, 7, 8, 9, 10, 11, 12]);
			//trace(_grid.saveToString());
			//mask = _grid;
			var t:Number = getTimer();
			_staticEntity.makeGrid();
			_collectableEntity.makeGrid();
			_glassEntity.makeGrid();
			_spikeEntity.makeGrid();
			//trace(getTimer() - t);
		}
		
		public function getGlassEntity():LevelGlassLayer
		{
			return _glassEntity;
		}
		public function getCollectableEntity():LevelCollectableLayer
		{
			return _collectableEntity;
		}
		public function getStaticEntity():LevelStaticLayer
		{
			return _staticEntity;
		}
		
		
		
		
		
		
		
		
		public function exportLevel(saveToClipboard:Boolean = true):String
		{
			var s:String = "";
			s += Level.EncodingVersion + "|";
			s += Level.ExtraData + "|";
			
			//add player first
			if (playerLoc == null) s += "0,0|";
			else s += playerLoc.x + "," + playerLoc.y + "|";
			
			s += _staticEntity.getTilemap().saveToString(",", ".") + "|";
			s += _collectableEntity.getTilemap().saveToString(",", ".") + "|";
			s += _glassEntity.getTilemap().saveToString(",", ".") + "|";
			s += _spikeEntity.getTilemap().saveToString(",", ".") + "|";
			
			s = compressBase64ByteArray(s);
			
			if(saveToClipboard)
				System.setClipboard(s);
				
			return s;
		}
		private function compressBase64ByteArray(s:String):String
		{
			var b:ByteArray = new ByteArray();
			
			b.writeUTFBytes(s);
			b.deflate();
			
			var e:Base64Encoder = new Base64Encoder();
			e.encodeBytes(b);
			return e.toString();
		}
		private function uncompressBase64ByteArray(s:String):String
		{
			var e:Base64Decoder = new Base64Decoder();
			e.decode(s);
			var b:ByteArray = e.toByteArray();
			b.inflate();
			return b.readUTFBytes(b.length);
			
			/*
			var b:ByteArray = new ByteArray();
			
			b.writeUTFBytes(s);
			b.deflate();
			
			var e:Base64Encoder = new Base64Encoder();
			e.encodeBytes(b);
			return e.toString();*/
		}
		
		
		public function importLevel(s:String):void
		{
			s = uncompressBase64ByteArray(s);
			
			
			var data:Array = s.split("|");
			var encoding:String = data[0];
			if (encoding == "1")
			{
				var extraData:String = data[1];
				
				var playerData:String = data[2];
				if (playerLoc == null) playerLoc = new Point();
				playerLoc.x = int(playerData.split(",")[0]);
				playerLoc.y = int(playerData.split(",")[1]);
				
				var char:Character = Assets.WorldGameWorld.getCharacter();
				char.x =  playerLoc.x*16;
				char.y =  playerLoc.y * 16;
				
				_staticEntity.getTilemap().loadFromString(data[3], ",", ".");
				_collectableEntity.getTilemap().loadFromString(data[4], ",", ".");
				_glassEntity.getTilemap().loadFromString(data[5], ",", ".");
				_spikeEntity.getTilemap().loadFromString(data[6], ",", ".");
				
				
				
				var arr:Array = [];
				Assets.WorldGameWorld.getType("ring", arr);
				for (var c:int = 0; c < arr.length; c++)
				{
					Assets.WorldGameWorld.remove(arr[c]);
				}
				Assets.WorldGameWorld.getType("Key", arr);
				for (c = 0; c < arr.length; c++)
				{
					Assets.WorldGameWorld.remove(arr[c]);
				}
				Assets.WorldGameWorld.getType("StripedBox", arr);
				for (c; c < arr.length; c++)
				{
					Assets.WorldGameWorld.remove(arr[c]);
				}
				Assets.WorldGameWorld.getType("Lock", arr);
				for (c; c < arr.length; c++)
				{
					Assets.WorldGameWorld.remove(arr[c]);
				}
				
				
				
				
				var t:Tilemap = _collectableEntity.getTilemap();
				
				outer: for (var i:int = 0; i < t.rows; i++)
				{
					inner: for (var k:int = 0; k < t.columns; k++)
					{
						if (t.getTile(k, i) == 4) //heart (now ring)
						{
							t.setTile(k, i, 0);
							var ring:Ring = new Ring();
							ring.x = k * 16;
							ring.y = i * 16;
							Assets.WorldGameWorld.add(ring);//hacky to get around world is null error
						}
						if (t.getTile(k, i) >= 15 && t.getTile(k, i) <= 18)
						{
							senseiLoc = new Point(k * 16, i * 16);
						}
						if (t.getTile(k, i) == 14) //remove the player
							t.setTile(k, i, 0);
						if (t.getTile(k, i) == 5)
						{
							t.setTile(k, i, 0);
							
							var key:LockKey = new LockKey();
							key.x = k * 16;
							key.y = i * 16;
							Assets.WorldGameWorld.add(key);//hacky to get around world is null error
						}
						if (t.getTile(k, i) == 1)
						{
							t.setTile(k, i, 0);
							
							var box:StripedBox = new StripedBox();
							box.x = k * 16;
							box.y = i * 16;
							Assets.WorldGameWorld.add(box);//hacky to get around world is null error
						}
						if (t.getTile(k, i) == 6)
						{
							t.setTile(k, i, 0);
							
							var lockBox:LockBox = new LockBox();
							lockBox.x = k * 16;
							lockBox.y = i * 16;
							Assets.WorldGameWorld.add(lockBox);//hacky to get around world is null error
						}
					}
				}
			}
			/* Encoding A
			var s:String = "";
			s += EditableLevel.EncodingVersion + "|";
			s += EditableLevel.ExtraData + "|";
			
			//add player first
			if (playerLoc == null) s += "0,0|";
			else s += playerLoc.x + "," + playerLoc.y + "|";
			
			s += _staticEntity.getTilemap().saveToString(",", ".") + "|";
			s += _collectableEntity.getTilemap().saveToString(",", ".") + "|";
			s += _glassEntity.getTilemap().saveToString(",", ".") + "|";
			s += _spikeEntity.getTilemap().saveToString(",", ".") + "|";
			
			s = compressBase64ByteArray(s);
			
			System.setClipboard(s);
			*/
			
			
			Assets.sun.change();
			Assets.bg.change();
			for (var w:int = 0; w < Assets.clouds.length; w++)
			{
				Assets.clouds[w].change();
			}
			
			if (Assets.LevelToBeLoaded < 11)
			{
				if (!Assets.DayMusic.playing)//day is not playing, play it
				{
					Assets.loopMusic(Assets.DayMusic);
					Assets.fadeIn(Assets.DayMusic, 1);
				}
				if (Assets.NightMusic.playing)
					Assets.fadeOut(Assets.NightMusic,1);
					//Assets.NightMusic.stop();
			}
			else if (Assets.LevelToBeLoaded > 10)
			{
				if (!Assets.NightMusic.playing) //night music not playing, play it
				{
					Assets.loopMusic(Assets.NightMusic);
					Assets.fadeIn(Assets.NightMusic, 1);
				}
				if (Assets.DayMusic.playing)
					Assets.fadeOut(Assets.DayMusic,1);
					//Assets.DayMusic.stop();
			}
		}
		
		
	}

}