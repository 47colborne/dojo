import React from 'react'
import ReactDom from 'react-dom'

var Cell = React.createClass({
  componentDidMount(){
    this.neighbourCount = 0;
  },

  onBirth(data) {
    if (this._isNeighbour(data)) {
      this.neighbourCount += 1;
    }
  },

  onDeath(data) {
    if (this._isNeighbour(data)) {
      this.neighbourCount -= 1;
    }
  },

  onGeneration() {

  },

  _isNeighbour: function (data) {
    return Math.abs(data.x - this.props.x) === 1 || Math.abs(data.y - this.props.y) === 1;
  },

  render() {
    return (
      <div className="dead"></div>
    );
  }
});


module.exports = Cell;
