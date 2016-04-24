import React from 'react';
import { mount, shallow } from 'enzyme';
import chai from 'chai';
var expect = chai.expect;
import sinon from 'sinon';
import sinonChai from 'sinon-chai';
import chaiEnzyme from 'chai-enzyme';
chai.use(sinonChai);
chai.use(chaiEnzyme());

import Grid from '../app/components/Grid.jsx';
import Cell from '../app/components/cell.jsx';

describe('<Grid />', function () {
  it('should render its children', () => {
    const wrapper = mount(<Grid><Cell /><Cell /></Grid>);
    expect(wrapper.find('.cell').length).to.equal(2);
    expect(wrapper.find('.grid').length).to.equal(1);
  })
});