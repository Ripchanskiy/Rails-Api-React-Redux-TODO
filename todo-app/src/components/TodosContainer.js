import React, { Component } from 'react'
import axios from 'axios'

class TodosContainer extends Component {

  constructor(props) {
    super(props)
    this.state = {
      todos: []
    }
  }

  getTodos() {
    axios.get('/api/v1/todos')
      .then(response => {
        this.setState({todos: response.data})
      })
      .catch(error => console.log(error))
  }

  componentDidMount() {
    this.getTodos()
  }

  render() {
    return (
      <div>
        <div className="inputContainer">
          <input className="taskInput" type="text"
                 placeholder="Add a task" maxLength="50" />
        </div>
        <div className="listWrapper">
          <ul className="taskList">
          </ul>
        </div>
      </div>
    )
  }
}

export default TodosContainer