package  
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.utils.ByteArray;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import punk.ui.PunkTextField;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class EditableLevel extends Level 
	{
		
		
		public var textExport:PunkTextField;
		
		
		
		
		private var initialized:Boolean = false;
		private var _drawingRegion:Canvas;
		//private var _tempTiles:Tilemap;
		private var _tab:LevelEditorTab;
		private var _export:EditableLevelExport;
		private var _import:EditableLevelImport;
		
		private var _currentTile:uint = 1;
		
		private var _isDrawing:Boolean = false;
		private var _startX:Number = 0;
		private var _startY:Number = 0;
		
		public function EditableLevel() 
		{
			super();
			
			_drawingRegion = new Canvas(720, 464);
			addGraphic(_drawingRegion);
			//_tempTiles = new Tilemap(Assets.LEVEL_TILESET, 720, 464, 16, 16);
			//graphic = null;
			//addGraphic(_tiles);
			//addGraphic(_tempTiles);
			
			
			//_tempTiles.alpha = 0.5
			
		}
		
		override public function update():void
		{
			if(!initialized)
			{
				if(FP.stage != null)
				{
					FP.stage.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
					FP.stage.addEventListener(MouseEvent.MOUSE_UP, mUp);
					initialized = true;
				}
			}
			super.update();
			
			if (_isDrawing)
			{
				//temp draw
				//clearTemp();
				
				var endX:Number = Input.mouseX < 0 ? 0: Input.mouseX > FP.screen.width? FP.screen.width : Input.mouseX;
				var endY:Number = Input.mouseY < 0 ? 0: Input.mouseY > 464? 464 : Input.mouseY;
				var rect:Rectangle = new Rectangle(_startX, _startY, endX - _startX, endY - _startY);
				_drawingRegion.fill(new Rectangle(0, 0, 720, 464), 0xFFFFFF, 0);
				_drawingRegion.drawRect(rect, Input.check(Key.SHIFT)?0xFF0000:0xFFFFFF, 0.5);
				
				//if (!Input.check(Key.SHIFT))
				//{
					//allTempSetRect(_startX / 16, _startY / 16, (Input.mouseX) / 16 - _startX / 16 + 1, (Input.mouseY) / 16 - _startY / 16 + 1, _currentTile, true);
				//}
				//else
				//{
					
					//_tempTiles.setRect(_startX / 16, _startY / 16, (Input.mouseX) / 16 - _startX / 16 + 1, (Input.mouseY) / 16 - _startY / 16 + 1,0);
					//_tempTiles.drawRect(new Rectangle(_startX, _startY, endX-_startX, endY-_startY), 0xFF0000, 0.5);
					/*
					(graphic as Graphiclist).remove(_tempTiles);
					_tempTiles = _tiles.getSubMap(0, 0, 720 / 16, 464 / 16);
					//_tempTiles.clearRect(_startX / 16, _startY / 16, (Input.mouseX) / 16 - _startX / 16 + 1, (Input.mouseY) / 16 - _startY / 16 + 1);
					addGraphic(_tempTiles);*/
				//}
			}
		}
		
		
		private function mUp(e:MouseEvent):void 
		{
			if (_isDrawing)
			{
				/*if (!Input.check(Key.SHIFT))
					_tiles.setRect(_startX / 16, _startY / 16, (Input.mouseX) / 16 - _startX / 16 + 1, (Input.mouseY) / 16 - _startY / 16 + 1, _currentTile);
				else
					_tiles.setRect(_startX / 16, _startY / 16, (Input.mouseX) / 16 - _startX / 16 + 1, (Input.mouseY) / 16 - _startY / 16 + 1,0);
				_tempTiles.setRect(0, 0, 720 / 16, 464 / 16,0);
				*/
				var endX:Number = Input.mouseX < 0 ? 0: Input.mouseX > FP.screen.width? FP.screen.width : Input.mouseX;
				var endY:Number = Input.mouseY < 0 ? 0: Input.mouseY > 464? 464 : Input.mouseY;
				var rect:Rectangle = new Rectangle(_startX, _startY, endX - _startX, endY - _startY);
				//trace("Before:",rect);
				if (rect.width < 0) { rect.x += rect.width; rect.width = -rect.width; }
				if (rect.height < 0) { rect.y += rect.height; rect.height = -rect.height; }
				//trace("After :",rect);
				//for (var i:int = rect.y/_staticTiles.tileHeight - 1; i < (rect.y + rect.height)/_staticTiles.tileHeight + 1; i++)
				outer: for (var i:int = 0; i < _staticEntity.getTilemap().rows; i++)
				{
					//for (var k:int = rect.x/_staticTiles.tileWidth - 1; k < (rect.x + rect.width)/_staticTiles.tileWidth + 1; k++)
					inner: for (var k:int = 0; k < _staticEntity.getTilemap().columns; k++)
					{
						if (rect.contains(k * _staticEntity.getTilemap().tileHeight + 8, i * _staticEntity.getTilemap().tileWidth + 8))//if the point is in it
						{
							if (Level.EmptyNumbers.indexOf(_currentTile) != -1 || Input.check(Key.SHIFT))
							{
								//apply change to spike tiles
								_staticEntity.getTilemap().setTile		(k, 		i, 		0);
								_collectableEntity.getTilemap().setTile	(k, 		i, 		0);
								_glassEntity.getTilemap().setTile		(k, 		i, 		0);
								_spikeEntity.getTilemap().setTile		(k, 		i, 		0);
							}
							else if (Level.StaticNumbers.indexOf(_currentTile) != -1)
							{
								//apply change to static tiles
								_staticEntity.getTilemap().setTile(k, 		i, 		_currentTile);
								_collectableEntity.getTilemap().setTile(k, 	i, 		0);
								_glassEntity.getTilemap().setTile(k, 		i, 		0);
								_spikeEntity.getTilemap().setTile(k, 		i, 		0);
							}
							else if (Level.CollectableNumbers.indexOf(_currentTile) != -1)
							{
								//apply change to collectable tiles
								_staticEntity.getTilemap().setTile(k, 		i, 		0);
								_collectableEntity.getTilemap().setTile(k, 	i, 		_currentTile);
								_glassEntity.getTilemap().setTile(k, 		i, 		0);
								_spikeEntity.getTilemap().setTile(k, 		i, 		0);
								if (_currentTile >= 14 && _currentTile <= 18)
								{
									//trace(senseiLoc, _currentTile);
									if (_currentTile == 14)
									{
										if(playerLoc != null)
											_collectableEntity.getTilemap().setTile(playerLoc.x, 	playerLoc.y, 	0);
										else playerLoc = new Point();
										playerLoc.x = k;
										playerLoc.y = i;
									}
									if (_currentTile >=15 && _currentTile <=18)
									{
										if(senseiLoc != null)
											_collectableEntity.getTilemap().setTile(senseiLoc.x, 	senseiLoc.y, 	0);
										else senseiLoc = new Point();
										senseiLoc.x = k;
										senseiLoc.y = i;
									}
									//destroy other location
									break outer;
								}
								
							}
							else if (Level.GlassNumbers.indexOf(_currentTile) != -1)
							{
								//apply change to glass tiles
								_staticEntity.getTilemap().setTile(k, 		i, 		0);
								_collectableEntity.getTilemap().setTile(k, 	i, 		0);
								_glassEntity.getTilemap().setTile(k, 		i, 		_currentTile);
								_spikeEntity.getTilemap().setTile(k, 		i, 		0);
							}
							else if (Level.SpikeNumbers.indexOf(_currentTile) != -1)
							{
								//apply change to spike tiles
								_staticEntity.getTilemap().setTile(k, 		i, 		0);
								_collectableEntity.getTilemap().setTile(k, 	i, 		0);
								_glassEntity.getTilemap().setTile(k, 		i, 		0);
								_spikeEntity.getTilemap().setTile(k, 		i, 		_currentTile);
							}
							//trace(_currentTile + " is being set [" + k + "," + i + "]");
							
							
							//catch player's position if overwritten
							if (playerLoc != null && _collectableEntity.getTilemap().getTile(playerLoc.x, playerLoc.y) != 14)
							{
								playerLoc = null;
							}
						}
					}
				}
				
				generateCollisionData();
				
				
				
			}
			_isDrawing = false;
		}
		
		private function mDown(e:MouseEvent):void 
		{
			//below tile tab and export button
			if (Input.mouseY > 20 && Input.mouseY < 464 && !(Input.mouseX > 665 && Input.mouseY < 76))
			{
				_isDrawing = true;
				_startX = Input.mouseX;
				_startY = Input.mouseY;
			}
		}
		
		override public function added():void
		{
			super.added();
			
			_tab = new LevelEditorTab();
			world.add(_tab);
			
			_export = new EditableLevelExport();
			world.add(_export);
			
			_import = new EditableLevelImport();
			world.add(_import);
			
			textExport = new PunkTextField("Import Level Data", 718-200, 4, 200, 20);
			world.add(textExport);
		}
		
		
		public function getLevelEditorTab():LevelEditorTab
		{
			return _tab;
		}
		
		public function setCurrentTile(t:LevelEditorTile):void
		{
			_tab.unselectCurrentTile();
			_currentTile = t.getTiles().frame;
			_tab.selectCurrentTile(t);
		}
		public function getCurrentTile():uint
		{
			return _currentTile;
		}
		
		
		
		
	}

}