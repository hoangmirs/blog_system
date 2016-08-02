class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy, :edit]
  def create
    @entry = Entry.find_by(id: params[:comment][:entry_id])
    @comment = @entry.comments.build(entry_params)
    if @comment.save
      flash[:success] = "Commented"
    else
  	  flash[:danger] = "You must type comment text!"
    end
      redirect_to @entry
  end

  def index
    redirect_to root_url
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def update
  	@comment = Comment.find_by(id: params[:id])
  	@comment.content = params[:comment][:content]
    if @comment.save
      flash[:success] = "Edited"
      redirect_to @entry
    else
  	  @feed_items = []
  	  render 'static_pages/home'
    end
  end

  def destroy
    Comment.find_by(id: params[:id]).destroy
    flash[:success] = "comment deleted"
    redirect_to root_url
  end

  private

    def entry_params
      params.require(:comment).permit(:content, :user_id)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end
