PIXI = require("pixi.js")
App = require("./App")
Config = require("./data/config")

app = new App Config.width,Config.height,{}
app.animation = false
