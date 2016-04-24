import { expect, sinon, React, shallow, mount } from './helpers/spec-helper.js';

import App from '../app/components/app';

describe('<App />', function () {
  it('should an element', function () {
    const wrapper = shallow(<App />);
    expect(wrapper.find('#app')).to.have.length(1);
  });
});