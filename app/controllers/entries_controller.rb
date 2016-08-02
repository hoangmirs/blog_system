class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy, :edit]

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Entry created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def show
    @entry = Entry.find(params[:id])
    @comment = Comment.new if logged_in?
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find_by(id: params[:id])
    if @entry.update entry_params
      flash[:success] = "Edited"
      redirect_to @entry
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @entry.destroy
    flash[:success] = "Entry deleted"
    redirect_to root_url
  end

  private

    def entry_params
      params.require(:entry).permit(:title, :body, :picture)
    end

    def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end
