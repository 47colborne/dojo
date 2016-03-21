import React from 'react'
import ReactDom from 'react-dom'

var Cell = React.createClass({

  componentDidMount(){
    this.neighbourCount = 0;
  },

  onBirth(msg) {

    if (msg.x - this.props.x === 1) {
      this.neighbourCount += 1;
    }

  },

  render() {
    return (
      <div className="dead"></div>
    );
  }
});


module.exports = Cell;