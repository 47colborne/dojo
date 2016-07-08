import React, { Component } from 'react';
import Grid from './Grid.jsx';
import Cell from './cell.jsx';

import '../styles/game.css';

class Game extends Component {
  
  
  constructor(props) {
    super(props);
    
    this.state = { 
      symbols: [],
      player: "X",
      statusMessage: ''
     }
  }

  onCellClicked(index) {
    if (!this.state.symbols[index] ) {
      var newSymbols = this.state.symbols;
      newSymbols[index] = this.state.player;
      var newPlayer = this.state.player == "X" ? "O" : "X";
      this.setState({ symbols: newSymbols, player: newPlayer }, () => this.checkForWin(index));
    }
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

  checkForWin(index) {
    // var letter = this.state.symbols[index];
    // if (this.state.symbols[0] == this.state.player && this.state.symbols[1] == this.state.player) {
    //   this.setState({statusMessage: this.state.player + " Wins!"});
    // }
    
    for(var row_number = 0; row_number < this.props.size ** 2; row_number = row_number + this.props.size) {
      console.log(row_number);
      for(var index = row_number * this.props.size + 1; index < row_number * this.props.size + row_number; index++) {
        if (this.state.symbols[index] != this.state.symbols[index - 1]) {
          console.log(index);
          return false;
        }
      }
    }

    return true;
  }


  render () {
    return (
      <div id="game">
        <h2 className="game-status">{ this.state.statusMessage }</h2>
        <Grid>
          { this._renderCells() }
        </Grid>
      </div>
    )
  }
}

export default Game;