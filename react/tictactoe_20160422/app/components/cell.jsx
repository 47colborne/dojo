import React, { Component } from 'react';
import ReactDOM from 'react-dom';

import '../styles/cell.css';

class Cell extends Component {
  render () {
    return (
      <div className="cell" onClick={ () => this.props.onClick(this.props.index) }>
        { this.props.symbol }
      </div>
    )
  }
}

export default Cell;