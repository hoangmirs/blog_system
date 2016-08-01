class StaticPagesController < ApplicationController
  def home
  	if logged_in?
      @entry = current_user.entries.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @comment = Comment.new
    else
      @feed_items = get_feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
