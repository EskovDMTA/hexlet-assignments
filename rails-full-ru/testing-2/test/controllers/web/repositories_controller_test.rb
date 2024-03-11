# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  include WebMock::API
  test 'should create repository' do
    repository_url = 'https://github.com/octokit/octokit.rb'
    stub_request(:get, 'https://api.github.com/repos/octokit/octokit.rb').
      to_return(body: load_fixture('files/response.json'), status: 200)
    post repositories_path, params: { repository: { link: repository_url }}
    repository = Repository.last
    assert_equal repository.link, 'https://github.com/octokit/octokit.rb'
    assert_equal "This your first repo!", repository.description
    assert_redirected_to root_path
  end
end
