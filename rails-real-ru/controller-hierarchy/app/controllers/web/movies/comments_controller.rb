# frozen_string_literal: true

module Web
  module Movies
    class CommentsController < Web::Movies::ApplicationController
      before_action :set_comment, only: %i[edit update destroy]

      def index
        @comments = resource_movie.comments
      end

      def new
        @comment = resource_movie.comments.build
      end

      def create
        @comment = resource_movie.comments.build(comment_params)
        if @comment.save
          redirect_to movie_comments_path, notice: "Comment create"
        else
          render new
        end
      end

      def edit; end

      def update
        if @comment.update(comment_params)
          redirect_to movie_comments_path, notice: "Comment update"
        else
          render edit
        end

      end

      def destroy
        @comment.destroy
        redirect_to movie_comments_path, notice: 'Comment was successfully destroyed.'
      end

      private

      def set_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:body)
      end
    end
  end
end
