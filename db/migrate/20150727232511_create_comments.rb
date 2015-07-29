class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.string :author
      t.string :content
      t.references :post, index: true, foreign_key: true
    end
  end
end
