class Add < ActiveRecord::Migration[6.1]
  def change
    add_column :repository_checks, :result, :json
  end
end
