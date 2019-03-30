PlayerData  = require '../assets/player/Player.JSON'
PlayerPNG   = require '../assets/player/Player.png'

class Player

  animations      : {}
  x               : 100
  y               : 725
  animationSpeed  : 0.1
  app             : null
  scale           : 2
  xSpeed          : 0
  ySpeed          : 0
  direction       : true
  crouch          : false

  constructor: (app) ->
    @app = app
    @build()

  build:=>
    for animation, frames of PlayerData.animations
      textureFrames = []
      for image in frames
        textureFrames.push(PIXI.Texture.fromFrame(image))
      @animations[animation] = new PIXI.extras.AnimatedSprite(textureFrames)
      @animations[animation].x = @x
      @animations[animation].y = @y
      @animations[animation].animationSpeed = @animationSpeed
      @animations[animation].alpha = 0
      @animations[animation].scale.x = @scale
      @animations[animation].scale.y = @scale
      @animations[animation].active = false
      @animations[animation].anchor.set 0.5
      @app.stage.addChild(@animations[animation])

    @animations['adventurer-idle'].play()
    @animations['adventurer-idle'].alpha = 1
    @animations['adventurer-idle'].active = true
    @animations['adventurer-jump'].loop = false
    @app.addAnimationNodes(@)

  changeActiveAnimation:(newActive)=>
    for key, value of @animations
      if value.active
        value.gotoAndStop(0)
        value.alpha = 0
        value.active = false
    @animations[newActive].play()
    @animations[newActive].alpha = 1
    @animations[newActive].x = @x
    @animations[newActive].y = @y
    @animations[newActive].active = true
    @animations[newActive].scale.x = @scale * @direction
    true

  collisions:=>
    if @y >= 715
      @onGround = true
      @jumping = false
    else
      @onGround = false

  animate:=>
    if @crouch
      if !@animations['adventurer-crouch'].active
        @changeActiveAnimation('adventurer-crouch')
      return 0
    @x += @xSpeed
    @y += @ySpeed
    @collisions()
    if @xSpeed != 0
      @direction =  @xSpeed/Math.abs(@xSpeed)
      if !@animations['adventurer-run'].active && !@animations['adventurer-jump'].active
        @changeActiveAnimation('adventurer-run')
      for key, value of @animations
        if value.active
          value.x = @x
          value.y = @y
          value.scale.x = @scale * @direction
    if @ySpeed == 0
      if @xSpeed == 0
        if !@animations['adventurer-idle'].active
          @changeActiveAnimation('adventurer-idle')
      else
        @changeActiveAnimation('adventurer-run') unless @animations['adventurer-run'].active
    if @ySpeed != 0
      if !@animations['adventurer-jump'].active
        @changeActiveAnimation('adventurer-jump')
      @animations['adventurer-jump'].y = @y
      @ySpeed += .7
      @ySpeed = 0 if @onGround

module.exports = Player
