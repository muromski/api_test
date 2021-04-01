# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :job_applications
  validates_presence_of :email
  validates_presence_of :password
  validates_uniqueness_of :email
end
