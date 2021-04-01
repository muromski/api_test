# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    id { 1 }
    title { 'programmer' }
    salary { 700 }
    languages { 'germany' }
    shifts { 'monday, tuesday' }
  end
end
