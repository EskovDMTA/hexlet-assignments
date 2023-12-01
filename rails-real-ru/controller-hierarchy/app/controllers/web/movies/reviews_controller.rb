# frozen_string_literal: true

module Web
  module Movies
    class ReviewsController < Web::Movies::ApplicationController
      before_action :set_review, only: %i[edit update destroy]

      def index
        @reviews = resource_movie.reviews
      end

      def edit
      end

      def new
        @review = resource_movie.reviews.build
      end

      def create
        @review = resource_movie.reviews.build(review_params)
        if @review.save
          redirect_to movie_reviews_path, notice: "Review create"
        else
          render new
        end
      end

      def update
        @review = Review.find(params[:id])
        if @review.update(review_params)
          redirect_to movie_reviews_path, notice: "Review update"
        else
          render edit
        end

      end

      def destroy
        @review.destroy
        redirect_to movie_reviews_path, notice: 'Review was successfully destroyed.'
      end

      private

      def set_review
        @review = Review.find(params[:id])
      end

      def review_params
        params.require(:review).permit(:body)
      end
    end
  end
end
