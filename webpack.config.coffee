HtmlWebpackPlugin = require('html-webpack-plugin')
webpack = require('webpack')
path = require('path')
UglifyJsPlugin = require('uglifyjs-webpack-plugin')

config =
  devtool:'inline-source-map'
  entry: './src/main'
  output:
    path: path.resolve(__dirname, 'dist')
    filename: 'bundle.js'
  module: rules: [ {
    test: /\.coffee$/,
    loader: "coffee-loader"
    options: transpile: presets: ['env']
  }
  {
    test: /\.(png|jp(e*)g|gif|json)$/
    use:
      loader: 'url-loader'
      options:
        limit: 8000
        name: 'image/[name].[ext]'
  } ]
  resolve: extensions: [".web.coffee", ".web.js", ".coffee", ".js"]
  plugins: [
    # new UglifyJsPlugin()
    new HtmlWebpackPlugin()
  ]



module.exports = config
