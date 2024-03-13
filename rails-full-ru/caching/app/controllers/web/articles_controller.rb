# frozen_string_literal: true

class Web::ArticlesController < Web::ApplicationController
  caches_action :show

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

end
