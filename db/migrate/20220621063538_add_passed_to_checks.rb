class AddPassedToChecks < ActiveRecord::Migration[6.1]
  def change
    add_column :repository_checks, :passed, :boolean
  end
end
