class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
  end

  def search
    @params = params[:search]

    if @params.blank?
      redirect_to root_path
    else
      @results = User.where(
        "LOWER(CONCAT(name, surname)) LIKE '%#{@params.downcase}%'"
      )
    end
  end
end
