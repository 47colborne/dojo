import React from 'react';
import {mount, shallow} from 'enzyme';
import {expect} from 'chai';

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
    // describe('with an empty cell', function () {
    //   it('marks the cell with the first player`s symbol', function () {
    //     const wrapper = mount(<Game size={2}/>);
    //
    //     const cell = wrapper.find(Cell).at(0).simulate('click')
    //
    //     // wrapper.instance().onCellClicked(cell.instance());
    //     console.log(wrapper.state())
    //     console.log(cell.props())
    //     wrapper.setState({symbols: ['X']})
    //     expect(cell.props.symbol).to.equal('X');
    //   });
    // });
  });
});