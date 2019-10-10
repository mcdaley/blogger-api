class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name,     null: false, default: ''
      t.string :last_name,      null: false

      t.timestamps
    end
  end
end
