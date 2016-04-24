import React, { Component } from 'react';
import ReactDOM from 'react-dom';

// import '../styles/cell.css';

class Grid extends Component {
  render () {
    return (
      <div className="grid">
        { this.props.children }
      </div>
    )
  }
}

export default Grid;