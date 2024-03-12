class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    repository = Repository.find(repository_id)
    repository.update_from_github
  rescue StandardError => e
    repository.update(aasm_state: :failed)
  end
end
