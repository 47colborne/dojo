import { connect } from 'react-redux'
import { addTodo } from '../reducers/index.js'
import TodoList from './TodoList.jsx'

const mapStateToProps = (state) => {
  return {
    todos: state.todos
  }
};

const mapDispatchToProps = (dispatch) => {
  return {
    onAdd: (title) => { dispatch(addTodo(title)) }
  }
};

const VisibleTodoList = connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);

export default VisibleTodoList;