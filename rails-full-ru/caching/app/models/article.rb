# frozen_string_literal: true

class Article < ApplicationRecord
  def last_reading_date
    Rails.cache.fetch("articles/#{id}/last_reading_date", expires_in: 12.hours) do
      Time.current
    end
  end
end
