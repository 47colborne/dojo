import React from 'react';
import ReactDOM from 'react-dom';
import App from './app/components/app';
import { createStore } from 'redux';
import { Provider } from 'react-redux';

import todoApp from './app/reducers/index'

import './app/styles/global';

let store = createStore(todoApp);

ReactDOM.render(
	<Provider store={ store }>
		<App />
	</Provider>,
	document.getElementById('root')
);