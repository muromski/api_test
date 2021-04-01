# frozen_string_literal: true

class JobSerializer < ActiveModel::Serializer
  attributes :title, :final_salary, :languages

  def final_salary
    hours = ((object.shifts.count ',') + 1) * 8
    object.salary * hours
  end
end
