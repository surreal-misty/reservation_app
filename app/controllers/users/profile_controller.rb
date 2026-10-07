class Users::ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def edit
  end

  def update
    if current_user.update(profile_params)
      redirect_to users_profile_path, notice: "プロフィールを更新しました"
    else
      flash.now[:alert] = "プロフィールを更新できませんでした"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:image, :name, :introduction)
  end
end
