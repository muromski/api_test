# frozen_string_literal: true

class ChangeJsonToJsonb < ActiveRecord::Migration[6.1]
  def change
    change_column :jobs, :languages, :jsonb
  end
end
