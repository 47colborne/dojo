import React from 'react';
import { mount, shallow } from 'enzyme';
import {expect} from 'chai';

import App from '../app/components/app';

describe('<App />', function () {
  it('should an element', function () {
    const wrapper = shallow(<App />);
    expect(wrapper.find('#app')).to.have.length(1);
  });
});