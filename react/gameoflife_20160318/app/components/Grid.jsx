import React from 'react'
import ReactDom from 'react-dom'
import Cell from './cell'

module.exports = React.createClass({
  renderCell(key) {
    return <Cell key={key} />;
  },

  renderCells() {
    let cells = [];
    for(var i = 0; i < this.props.size**2; i++) {
      cells.push(this.renderCell(i))
    }
    return cells
  },

  render() {
    return (
      <div>
        {this.renderCells()}
      </div>
      )

  }
});

