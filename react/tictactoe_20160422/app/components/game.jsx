import React, { Component } from 'react';
import Grid from './Grid.jsx';
import Cell from './cell.jsx';

import '../styles/game.css';

class Game extends Component {
  
  
  constructor(props) {
    super(props);
    
    this.state = { 
      symbols: [],
      player: "X"
     }
  }
   

  onCellClicked(cell) {
    var newSymbols = this.state.symbols;
    newSymbols[cell.props.index] = this.state.player;
    this.setState({symbols: newSymbols})
  }

  _renderCell(index) {
    return <Cell key={index} index={index} symbol={ this.state.symbols[index] } onClick={ this.onCellClicked } />
  }

  _renderCells() {
    var numCells = this.props.size ** 2;
    var cells = [];

    for(var i = 0; i < numCells; i++) {
      cells.push(this._renderCell(i));
    }

    return cells;
  }

  render () {
    return (
      <div id="game">
        <Grid>
          { this._renderCells() }
        </Grid>
      </div>
    )
  }
}

export default Game;