const path = require('path');
const webpack = require('webpack');

// env
const buildDirectory = './dist/';

module.exports = {
  entry: './index.js',
  devServer: {
    hot: true,
    inline: true,
    port: 7700,
    historyApiFallback: true,
  },
  resolve: {
    extensions: ['', '.css', '.js', '.jsx'],
  },
  output: {
    path: path.resolve(buildDirectory),
    filename: 'app.js',
    publicPath: 'http://localhost:7700/dist',
  },
  externals: {
    'cheerio': 'window',
    'react/lib/ExecutionEnvironment': true,
    'react/lib/ReactContext': true,
  },
  postcss: (webpack) => {
    return [
      require("postcss-import")({addDependencyTo: webpack}),
      require("postcss-url")(),
      require('postcss-cssnext')()
    ]
  },
  module: {
    loaders: [{
      test: /\.jsx?$/,
      exclude: /(node_modules|bower_components)/,
      loader: ['babel'],
      query: {
        presets: ['react', 'es2015', 'stage-0'],
      }
    },
      {
        test: /\.css$/,
        loaders: ['style', 'css', 'postcss']
      }],
  },
  plugins: [],
};