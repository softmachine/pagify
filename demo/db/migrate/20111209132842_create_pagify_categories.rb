class CreatePagifyCategories < ActiveRecord::Migration

  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end
  end

  # add_index :categories, :name, :unique => true

end
