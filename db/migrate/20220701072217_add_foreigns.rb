class AddForeigns < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :repositories, :users
    add_foreign_key :repository_checks, :repositories
  end
end
