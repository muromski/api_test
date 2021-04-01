# frozen_string_literal: true

class JobApplication < ApplicationRecord
  has_one :job
  has_one :user
  validates_presence_of :user_id, :job_id
end
