class Shift < ApplicationRecord
  belongs_to :job
  validates_presence_of :start_date, :finish_date
end
