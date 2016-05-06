import React, { Component } from 'react';
import VisibleTodoList from './VisibleTodoList.jsx'

import '../styles/app';

class App extends Component {
	render () {
		return (
			<div id="app">
				Hello World!
        <div id="globalid">
          <VisibleTodoList />
        </div>
			</div>
		)
	}
}

export default App;
