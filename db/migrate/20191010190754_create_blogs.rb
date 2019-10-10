class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.string    :title,     null: false
      t.string    :summary
      t.datetime  :posted
      t.integer   :user_id

      t.timestamps
    end
  end
end
