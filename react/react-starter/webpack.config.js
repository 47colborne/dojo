'use strict';

let path = require('path');
let webpack = require('webpack');

const PATH = (p) => path.resolve(__dirname, p || '');

const COMMON = {
	context: PATH('app'),
	entry: {
		app: ['babel-polyfill', './index.js']
	},
	output: {
		filename: 'bundle.js',
		path: PATH('build')
	},
	module: {
		loaders: [{
			test: /\.jsx?$/,
			loader: 'babel',
			include: PATH('app')
		}, {
			test: /\.css$/,
			loaders: ['style', 'css', 'postcss']
		}]
	},
	resolve: {
		extensions: ["", ".css", ".js", ".jsx"]
	},
	postcss: (webpack) => {
		return [
			require("postcss-import")({ addDependencyTo: webpack }),
			require("postcss-url")(),
			require('postcss-cssnext')()
		]
	},
	debug: true,
	devtool: 'cheap-source-map',
	devServer: {
		contentBase: PATH('build'),
		hot: true,
		inline: true,
		stats: 'error-only'
	}
}

module.exports = COMMON;
