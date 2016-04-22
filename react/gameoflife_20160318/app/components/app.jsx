import React, { Component } from 'react';
import ReactDOM from 'react-dom';

//import '../styles/app';

class App extends Component {
  render() {
    return (
      <Grid size={10} game={this} />
    )
  }
}

export default App;
