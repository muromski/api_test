# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :job_applications
  validates_presence_of :title, :salary, :languages, :shifts
end
