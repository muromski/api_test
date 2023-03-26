# frozen_string_literal: true

class JobApplicationSerializer < ActiveModel::Serializer
  attributes :job_id, :user_id
end
