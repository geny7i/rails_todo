class Task < ApplicationRecord
  validates :title, :contest, :due_at, presence: true
  belongs_to :user
end
