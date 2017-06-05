class AddTitleAndCreatorAndLastEditorToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :title, :string, default: "UnknownTitle", null: false
    add_column :documents, :creator, :integer, default: "Unknown", null: false
    add_column :documents, :last_editor, :integer, null: true
    rename_column :documents, :url, :cloudinary_uri
  end
end
