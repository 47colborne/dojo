import { expect, sinon, React, shallow, mount } from './helpers/spec-helper.js';

import Cell from '../app/components/cell.jsx';

describe('<Cell />', function () {
  it('should render an empty cell if prop is empty', ()=> {
    const wrapper = shallow(<Cell symbol=""/>);
    expect(wrapper.find('.cell')).to.have.text('');
  });

  it('should render an x if prop symbol is x', () =>{
    const wrapper = shallow(<Cell symbol="X" />);
    expect(wrapper.find('.cell')).to.have.text('X');
  });

  it('should trigger a callback from props onClick', () => {
    var callback = sinon.spy();
    const wrapper = shallow(<Cell symbol="X" onClick={ callback }/>);
    wrapper.simulate('click');
    expect(callback).to.have.been.calledWith(wrapper.instance());
  });
});