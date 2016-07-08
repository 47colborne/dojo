import {expect, sinon, React, shallow, mount} from './helpers/spec-helper.js';

import Game from '../app/components/game.jsx';
import Grid from '../app/components/Grid.jsx';
import Cell from '../app/components/cell.jsx';

describe('<Game />', function () {
  it('renders a grid', function () {
    const wrapper = shallow(<Game />);
    expect(wrapper.find(Grid)).to.have.length(1);
  });

  it('should render the correct number of cells', () => {
    const wrapper = shallow(<Game size={2}/>);
    expect(wrapper.find(Grid).props().children).to.have.length(4)
  });

  it('creates empty cells', () => {
    const wrapper = shallow(<Game size={2}/>);
    expect(wrapper.find(Cell).at(0).props().symbol).to.be.empty;
  });

  it('passes click handler to cells', () => {
    const wrapper = shallow(<Game size={2}/>);
    expect(wrapper.find(Cell).at(0).props().onClick).to.be.ok;
    expect(wrapper.find(Cell).at(0).props().onClick).to.equal(wrapper.instance().onCellClicked);
  });

  describe('onCellClicked', function () {
    describe('with an empty cell', function () {
      it('marks the cell with the first player`s symbol', function () {
        const wrapper = mount(<Game size={1}/>);

        const cell = wrapper.find(Cell).at(0);

        wrapper.instance().onCellClicked(0);
        expect(cell.props().symbol).to.equal('X');
      });

      it('should change the player for the next click', () => {
        const wrapper = mount(<Game size={2}/>);

        const cell = wrapper.find(Cell).at(1);

        wrapper.instance().onCellClicked(0);
        wrapper.instance().onCellClicked(1);


        expect(cell.props().symbol).to.equal('O');
      })

    });

    describe('with filled in cell', function () {
      it('should not be able to change the symbol once set', function () {
        const wrapper = mount(<Game size={2}/>);

        const cell = wrapper.find(Cell).at(0);

        wrapper.instance().onCellClicked(0);

        wrapper.setState({player: 'O'});
        wrapper.instance().onCellClicked(0);
        expect(cell.props().symbol).to.equal('X');
      });

      it('should not change the player for the next click', () => {
        const wrapper = mount(<Game size={2}/>);
        const cell = wrapper.find(Cell).at(1);

        wrapper.instance().onCellClicked(0);
        wrapper.instance().onCellClicked(0);
        wrapper.instance().onCellClicked(1);

        expect(cell.props().symbol).to.equal('O');
      });
    });
  });

  describe('status message', () => {
    it('displays nothing when the game is still in progress', function () {
      const wrapper = mount(<Game size={2}/>);
      wrapper.instance().onCellClicked(0);
      expect(wrapper.find('.game-status').text()).to.be.empty;
    })

    describe('when a player has a horizontal row', function () {
      it('displays a victory message for the winning player', function () {
        const wrapper = mount(<Game size={2}/>);
        wrapper.instance().onCellClicked(0);
        wrapper.instance().onCellClicked(1);
        expect(wrapper.find('.game-status')).to.have.text("X Wins!");
      })
    })
  });
});