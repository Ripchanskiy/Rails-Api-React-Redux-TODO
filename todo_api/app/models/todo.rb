class Todo < ApplicationRecord
  validates :title, :done, presence: true
end
