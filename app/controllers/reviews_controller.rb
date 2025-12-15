class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :authorize_owner!, only: [:edit, :update, :destroy]

  def create
    @sauna = Sauna.find(params[:sauna_id])
    @review = @sauna.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @sauna, notice: "レビューを投稿しました"
    else
      @reviews = @sauna.reviews.includes(:user).order(created_at: :desc)
      flash.now[:alert] = "入力内容を確認してください"
      render "saunas/show", status: :unprocessable_entity
    end
  end

  def edit
    @sauna = @review.sauna
  end

  def update
    @sauna = @review.sauna

    if @review.update(review_params)
      redirect_to mypage_path, notice: "レビューを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to mypage_path, notice: "レビューを削除しました"
  end

  private

  def authorize_owner!
    redirect_to root_path, alert: "権限がありません" unless @review.user == current_user
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
