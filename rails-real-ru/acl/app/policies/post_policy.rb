# frozen_string_literal: true

class PostPolicy
  attr_reader :post, :user

  def initialize(user, post)
    @user = user
    @post = post
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end





  def update?
    post.author == user || user&.admin?
  end

  def destroy?
    user.admin?
  end

  def edit?
    post.author == user || user.admin?
  end

  def show?
    true
  end
end
