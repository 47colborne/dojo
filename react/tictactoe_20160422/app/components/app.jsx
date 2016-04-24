import React, { Component } from 'react';
import ReactDOM from 'react-dom';

import Game from './game.jsx';

import '../styles/app';

class App extends Component {
	render () {
		return (
			<div id="app">
				Hello World!
        <div id="globalid">
          global!
        </div>
				
				<Game />
			</div>
		)
	}
}

export default App;
