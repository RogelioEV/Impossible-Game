MapaData  = require '../assets/dungeon/dungeon.JSON'
Mapa      = require '../assets/Dungeon/mapa.JSON'
MapaPNG   = require '../assets/dungeon/Dungeon.png'


class Map
  app : null
  blocks: []
  constructor: (app) ->
    @app = app
    console.log 'new map'
    @build()

  build:=>
    i = 0
    for frame, data of MapaData.frames
      textureFrames = []
      textureFrames.push(PIXI.Texture.fromFrame(frame))
      @blocks[i] = new PIXI.extras.AnimatedSprite(textureFrames)
      console.log frame
      @blocks[i].x = 60 * i
      @blocks[i].y = 60 * i
      @app.stage.addChild @blocks[i]
      ++i
module.exports = Map