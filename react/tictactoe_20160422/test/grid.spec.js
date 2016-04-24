import { expect, sinon, React, shallow, mount } from './helpers/spec-helper.js';

import Grid from '../app/components/Grid.jsx';
import Cell from '../app/components/cell.jsx';

describe('<Grid />', function () {
  it('should render its children', () => {
    const wrapper = mount(<Grid><Cell /><Cell /></Grid>);
    expect(wrapper.find('.cell').length).to.equal(2);
    expect(wrapper.find('.grid').length).to.equal(1);
  })
});