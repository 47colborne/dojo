import React, { Component } from 'react';

class TodoList extends Component {
  constructor(props) {
    super(props);

    this.onRemove = this.onRemove.bind(this);
    this.renderTodo = this.renderTodo.bind(this);
  }

  renderTodo(todo) {
    return <li key={todo}>
      <input type="checkbox" onChange={ () => this.onRemove(todo) } />
      <span>{ todo }</span>
    </li>
  }

  onAdd() {
    this.props.onAdd(this.refs.input.value);
    this.refs.input.value = ''
  }

  onRemove(title) {
    this.props.onRemove(title)
    this.refs.input.focus()
  }

  componentDidMount() {
    this.refs.input.focus()
  }

  render () {
    return (
      <div>
        { this.props.todos.map(this.renderTodo) }

        <div>
          <input
            type="text"
            ref="input"
            placeholder="Enter a todo..."
            onKeyUp={ (e) => {
              if (e.keyCode == 13) {
                this.onAdd()
              }
            }}
          />
        </div>
      </div>
    )
  }
}

export default TodoList;