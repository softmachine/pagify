class CreatePagifyPages < ActiveRecord::Migration
  def change
    create_table :pagify_pages do |t|
      t.string :name
      t.string :title
      t.text   :content

      t.timestamps
    end
    add_index :pagify_pages, :name, :unique => true

  end
end
