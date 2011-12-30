class CreatePagifyTables < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.text   :content

      t.timestamps
    end
    add_index :pages, :name, :unique => true

    create_table :categories do |t|
      t.string :name
      t.string :title
      t.string :description

      t.timestamps
    end
    add_index :categories, :name, :unique => true

    create_table :pagify_categorizations do |t|
      t.integer :page_id
      t.integer :category_id
      t.integer :position

      t.timestamps
    end
  end
end
