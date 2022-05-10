class Article < ApplicationRecord
  belongs_to :user
  has_one :categories
end
