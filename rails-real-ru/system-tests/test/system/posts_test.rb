# frozen_string_literal: true

require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase

  def setup
    @post = posts(:one)
  end

  test 'creating a post' do
    visit posts_path
    click_on 'New Post'
    fill_in 'Title', with: 'New post'
    fill_in 'Body', with: 'New body'
    click_on 'Create Post'
    assert_text 'Post was successfully created.'
  end

  test 'updating post' do
    visit edit_post_path(@post)
    click_on 'Update Post'
    assert_text 'Post was successfully updated.'
  end

  test "delete post" do
    visit posts_path
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post was successfully destroyed."

  end



end

# END
