class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email, index: {unique: true}
      t.string :token
      t.string :avatar
      t.string :provider
      t.string :uid, index: {unique: true}

      t.timestamps
    end
  end
end
