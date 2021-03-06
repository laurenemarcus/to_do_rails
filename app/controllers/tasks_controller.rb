class TasksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @task = @list.tasks.new
  end

  def create
    @list = List.find(params[:list_id])
    @task = @list.tasks.new(task_params)
    if @task.save
      flash[:notice] = "Task successfully added!"
      redirect_to list_path(@task.list)
    else
      render :new
    end
  end

  def edit
    @list = List.find(params[:list_id])
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "Task succesfully updated! Woohoo!"
      redirect_to list_path(@task.list)
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @list = @task.list
    @task.destroy
    flash[:notice] = "Task succesfully deleted."
    redirect_to list_path(@list)
  end

  def done
    @task = Task.find(params[:id])
    @task.done = !@task.done
    redirect_to list_path(@task.list)
  end

private
  def task_params
    params.require(:task).permit(:description, :done)
  end

end
