class Url < ApplicationRecord
  # => Сallbacks
  ####################
  # => Validations
  ####################
  validates :short_version, :full_version, presence: true
  validates :short_version, :full_version, uniqueness: true
  # => Relations
  ####################
  # => Scopes
  ####################
  # => Methods
  ####################
end
