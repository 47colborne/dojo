'use strict';
const React = require('react');
const ReactDOM = require('react-dom');
const TestUtils = require('react-addons-test-utils');
import { shallow, mount } from 'enzyme';
const Cell = require('../app/components/cell');

jest.dontMock('../app/components/cell');

describe('Cell', function () {
  it('render a dead cell as default', () => {
    const wrapper = shallow(<Cell/>);
    expect(wrapper.find('.dead').length).toBe(1)
  });

  describe('onBirth', () => {
    beforeEach(() => {
      this.wrapper = mount(<Cell x={ 2 } y={ 3 }/>);
      this.cell = this.wrapper.instance();
    });

    describe('when event is from a neighbour', () => {
      it('increments the neighbour count', () => {
        this.cell.onBirth({x: this.cell.props.x - 1, y: this.cell.props.y + 1});
        this.cell.onBirth({x: this.cell.props.x, y: this.cell.props.y + 1});
        this.cell.onBirth({x: this.cell.props.x + 1, y: this.cell.props.y + 1});
        this.cell.onBirth({x: this.cell.props.x - 1, y: this.cell.props.y});
        this.cell.onBirth({x: this.cell.props.x + 1, y: this.cell.props.y});
        this.cell.onBirth({x: this.cell.props.x - 1, y: this.cell.props.y - 1});
        this.cell.onBirth({x: this.cell.props.x, y: this.cell.props.y - 1});
        this.cell.onBirth({x: this.cell.props.x + 1, y: this.cell.props.y - 1});
        expect(this.cell.neighbourCount).toBe(8);
      });
    });

    describe('when event is not from a neighbour', () => {
      it('should not increment neighbour count', () => {
        this.cell.onBirth({x: this.cell.props.x + 2, y: this.cell.props.y});
        expect(this.cell.neighbourCount).toBe(0);
      });
    });

    describe('when event is from itself', () => {
      it('should not increment neighbour count', () => {
        this.cell.onBirth({x: this.cell.props.x, y: this.cell.props.y});
        expect(this.cell.neighbourCount).toBe(0);
      });
    });
  });

  describe('onDeath', () => {
    beforeEach(() => {
      this.wrapper = mount(<Cell x={ 2 } y={ 3 }/>);
      this.cell = this.wrapper.instance();
    });

    describe('when event is from a neighbour', () => {
      it('decrements the neighbour count', () => {
        this.cell.neighbourCount = 8;

        this.cell.onDeath({x: this.cell.props.x - 1, y: this.cell.props.y + 1});
        this.cell.onDeath({x: this.cell.props.x, y: this.cell.props.y + 1});
        this.cell.onDeath({x: this.cell.props.x + 1, y: this.cell.props.y + 1});
        this.cell.onDeath({x: this.cell.props.x - 1, y: this.cell.props.y});
        this.cell.onDeath({x: this.cell.props.x + 1, y: this.cell.props.y});
        this.cell.onDeath({x: this.cell.props.x - 1, y: this.cell.props.y - 1});
        this.cell.onDeath({x: this.cell.props.x, y: this.cell.props.y - 1});
        this.cell.onDeath({x: this.cell.props.x + 1, y: this.cell.props.y - 1});

        expect(this.cell.neighbourCount).toBe(0);
      });
    });

    describe('when event is not from a neighbour', () => {
      it('should not decrement neighbour count', () => {
        this.cell.onDeath({x: this.cell.props.x + 2, y: this.cell.props.y});
        expect(this.cell.neighbourCount).toBe(0);
      });
    });

    describe('when event is from itself', () => {
      it('should not decrement neighbour count', () => {
        this.cell.onDeath({x: this.cell.props.x, y: this.cell.props.y});
        expect(this.cell.neighbourCount).toBe(0);
      });
    });
  });

  describe('onGeneration', () => {
    //describe('when the neighbour count is less than')
  });
});
