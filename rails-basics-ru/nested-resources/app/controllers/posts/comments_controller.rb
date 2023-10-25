class Posts::CommentsController < Posts::ApplicationController
  def new
    @comment = PostComment.new
  end

  def create
    @comment = resource_post.post_comments.build(comment_params)

    if @comment.save
      redirect_to post_path(resource_post) , notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @comment = PostComment.find(params[:id])
  end

  def update

    @comment = PostComment.find(params[:id])
    @comment.update(comment_params)
    if @comment.save
      redirect_to resource_post
    else
      render :edit
    end
  end

  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:post_comment).permit(:body)
  end
end
