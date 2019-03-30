Player      = require './elements/Player'
PlayerIMG   = require './assets/player/Player.json'
Mapa        = require './elements/Map'
MapIMG      = require './assets/dungeon/Dungeon.json'

class App extends PIXI.Application

  animation       : true
  animationNodes  : []

  constructor:(w,h,o)->
    super(w,h,o)
    document.body.appendChild @view
    @animate()
    PIXI.loader
      .add(MapIMG)
      .add(PlayerIMG)
      .load(@build)
    window.addEventListener 'keydown', @onKeyDown
    window.addEventListener 'keyup', @onKeyUp
    window.addEventListener 'touchstart', @onTouchStart

  build:()=>
    @player = new Player(@)
    @map = new Mapa(@)

  onTouchStart:(e)=>
    return if @player.crouch
    @player.ySpeed = -15 unless @player.animations['adventurer-jump'].active

  onKeyDown:(e)=>
    switch e.keyCode
      when 65   # A key = Run Left
        return if @player.crouch
        @player.xSpeed = -4

      when 68  # D key = Run Right
        return if @player.crouch
        @player.xSpeed = 4
      when 32  #Space key = Jump
        return if @player.crouch
        @player.ySpeed = -15 unless @player.animations['adventurer-jump'].active
      when 74
        console.log 'atack'
      when 75
        console.log 'slide'
      when 83  #S key = Crouch
        return if @player.animations['adventurer-jump'].active
        @player.crouch = true
        @player.xSpeed = 0
        @player.ySpeed = 0

  onKeyUp:(e)=>
    switch e.keyCode
      when 65 # Stop Running
        @player.xSpeed = 0
      when 68 #Stop Running
        @player.xSpeed = 0
      when 83 #Stop Crouching
        @player.crouch = false

  addAnimationNodes:(child)=>
    @animationNodes.push child
    null
  
  animate:=>
    @ticker.add ()=>
      for n in @animationNodes
        n.animate?()

    null

module.exports = App
