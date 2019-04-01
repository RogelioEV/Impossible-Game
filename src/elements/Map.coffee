MapaData  = require '../assets/dungeon/dungeon.JSON'
Mapa      = require '../assets/Dungeon/mapa.JSON'
MapaPNG   = require '../assets/dungeon/Dungeon.png'


class Map
  app : null
  blocks: []
  blocks2: []
  frames: []
  constructor: (app) ->
    @app = app
    console.log 'new map', Mapa.tileheight
    @build()

  build:=>
    for frame, data of MapaData.frames
      textureFrames = []
      textureFrames.push(PIXI.Texture.fromFrame(frame))
      @frames.push textureFrames
      
    for j in [0..90] by 1
      @blocks2[j] = new PIXI.extras.AnimatedSprite @frames[10]
      @blocks2[j].y = 737
      @blocks2[j].x = 16 * j
      @app.stage.addChild @blocks2[j]
    # console.log Mapa.layers[0].data
    for row in [0..Mapa.height-1] by 1
      for column in [0..Mapa.width-1] by 1
        # console.log row * Mapa.width + column
        tile = false
        switch Mapa.layers[0].data[row * Mapa.width + column]
          when 15
            tile = new PIXI.extras.AnimatedSprite @frames[10]
          when 53
            tile = new PIXI.extras.AnimatedSprite @frames[9]
        if tile
          tile.x = column * Mapa.tilewidth
          tile.y = (row-7) * Mapa.tileheight
          console.log 'tile', tile.x, tile.y
          @app.stage.addChild tile
          @blocks.push tile    
    console.log @blocks
module.exports = Map