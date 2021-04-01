# frozen_string_literal: true

class ChangeJsonbToString < ActiveRecord::Migration[6.1]
  def change
    change_column :jobs, :languages, :string
  end
end
