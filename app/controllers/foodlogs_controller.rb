class FoodlogsController < ApplicationController
  before_action :authenticate_user!

  def new
    @foodlog = current_user.foodlogs.build
    @foodlogs = current_user.foodlogs.where(customdate: params[:customdate])
  end

  def create
    @foodlog = current_user.foodlogs.build(foodlog_params)
    if @foodlog.save
      redirect_to new_foodlog_path(customdate: @foodlog.customdate)
    else
      redirect_to new_foodlog_path(customdate: @foodlog.customdate)
      flash[:notice] = "This didn't save, please ensure you have entered some food!"
    end
  end

  def foodlog_params
    params.require(:foodlog).permit(:food, :customdate)
  end

  def destroy
    @foodlog = Foodlog.find(params[:id])
    @foodlog.delete
    redirect_to new_foodlog_path(customdate: @foodlog.customdate)
  end

end
