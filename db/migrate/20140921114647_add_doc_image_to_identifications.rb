class AddDocImageToIdentifications < ActiveRecord::Migration
  def change
    add_column :identifications, :doc_image, :string
  end
end
