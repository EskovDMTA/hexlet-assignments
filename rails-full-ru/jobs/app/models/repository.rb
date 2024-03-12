# frozen_string_literal: true

class Repository < ApplicationRecord
  include AASM
  validates :link, presence: true, uniqueness: true

  # BEGIN
  aasm do
    state :created, initial: true
    state :fetching
    state :fetched
    state :failed

    event :start_fetching do
      transitions from: %i[created fetched], to: :fetching
    end

    event :finish_fetching do
      transitions from: :fetching, to: :fetched
    end

    event :mark_failed do
      transitions to: :failed
    end
  end

  def update_from_github
    octokit_repo = Octokit::Repository.from_url(self.link)
    repository_data = Octokit.client.repository(octokit_repo)
    update(description: repository_data['description'], owner_name: repository_data['owner']['login'], repo_name: repository_data['name'])
    finish_fetching!
  end
end
