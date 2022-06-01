class CreateRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :repositories do |t|
      t.integer :repo_id
      t.string :name
      t.string :link
      t.string :language
      t.references :user

      t.timestamps
    end
  end
end
