'use strict';
const React = require('react');
const ReactDOM = require('react-dom');
const TestUtils = require('react-addons-test-utils');
import { shallow, mount } from 'enzyme';
const Grid = require('../app/components/Grid');

jest.dontMock('../app/components/Grid');
jest.dontMock('../app/components/cell');

describe('Grid', function () {
  describe('render', () => {
    beforeEach(() => {
      this.wrapper = mount(<Grid size={2} />);
      this.grid = this.wrapper.instance();
    });

    it('should render the correct number of cells', () => {
      expect(this.wrapper.find('.dead').length).toBe(4)
    });

  });
});

