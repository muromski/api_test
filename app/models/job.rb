class Job < ApplicationRecord
  has_many :shifts
  validates_presence_of :title, :salary, :languages
end
