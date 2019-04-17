class Api::V1::TodosController < ApplicationController
  def index
    todos = Todo.order('created_at DESC')
    render json: todos
  end

  def create
    todo = Todo.new(todo_param)
    if todo.save
      render json: todo
    else
      render json: todo.errors, status: 422
    end
  end

  def update
    todo = Todo.find(params[:id])
    if todo.update_attributes(todo_param)
      render json: todo
    else
      render json: todo.errors, status: 422
    end
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy
    head :no_content
  end

  private

  def todo_param
    params.require(:todo).permit(:title, :done)
  end
end
