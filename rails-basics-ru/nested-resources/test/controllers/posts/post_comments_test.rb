# frozen_string_literal: true

require 'test_helper'

class PostsCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_attrs = {
      title: "new_title",
      body: "new_title"
    }
    @post = Post.create(@post_attrs)
    @comment = PostComment.create(body: "new_comment", post_id: @post)
  end

  test "should create comment to post" do
    post post_comments_path(@post), params: { post_comment: {body: "new_comment"} }
    assert @post.post_comments.length != 0
  end

  test "get edit" do
    comment = PostComment.create(body: "new body", post_id: @post.id)
    get edit_comment_path(comment)
    assert_response :success
  end

  test "should update comments edit" do
    comment = PostComment.find_by(body: post_comments(:one).body)
    comment.update(body: "NEW BODY")
    assert {comment.body == "NEW BODY"}
  end

  test "should delete comments" do
    comment = PostComment.find_by(body: post_comments(:two).body)
    comment.destroy
    assert {PostComment.all.length == 1}
  end
end
