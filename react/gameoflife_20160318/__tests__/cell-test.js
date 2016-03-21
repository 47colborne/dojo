'use strict';
const React = require('react');
const ReactDOM = require('react-dom');
const TestUtils = require('react-addons-test-utils');
const Cell = require('../app/components/cell');

jest.dontMock('../app/components/cell');


describe('Cell', () => {
  it('render a dead cell as default', () => {
    const cell = TestUtils.renderIntoDocument(
      <Cell/>
    );

    const cellNode = ReactDOM.findDOMNode(cell);

    expect(cellNode.className).toBe('dead');
  });

  describe('onBirth', () => {

    describe('neighbour', () => {
      it('should +1 on neighbourCount', () => {

        let coordinate = {x: 1, y: 1};

        const cell = TestUtils.renderIntoDocument(
          <Cell {...coordinate}/>
        );

        let msg = {x:2, y:2};
        cell.onBirth(msg);
        expect(cell.neighbourCount).toBe(1);
      });
    });

    describe('non-neighbour', () => {
      it('should not +1 on neighbourCount', () => {

        let coordinate = {x: 1, y: 1};

        const cell = TestUtils.renderIntoDocument(
          <Cell {...coordinate}/>
        );

        let msg = {x:4, y:1};
        cell.onBirth(msg);
        expect(cell.neighbourCount).toBe(0);
      });
    });
  });


});