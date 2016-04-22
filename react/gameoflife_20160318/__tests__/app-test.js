'use strict';
const React = require('react');
const ReactDOM = require('react-dom');
const TestUtils = require('react-addons-test-utils');
import { shallow, mount } from 'enzyme';
const App = require('../app/components/app');
const Grid = require('../app/components/Grid');

describe('App', function () {
  it('renders a grid with access to app', () => {
    const dom = mount(<App/>);
    expect(dom.find(Grid).first().props().game).toBe(dom.instance());
  });
});
