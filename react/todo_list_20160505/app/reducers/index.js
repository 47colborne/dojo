// Actions
const addTodo = (title) => {
  return {
    type: 'ADD_TODO',
    title: title
  }
};

// Reducers
const todoApp = (state = {todos: []}, action) => {
  switch (action.type) {
    case 'ADD_TODO':
      return {
        ...state,
        todos: [...state.todos, action.title]
      };
    default: return state
  }
};

export { todoApp as default, addTodo };