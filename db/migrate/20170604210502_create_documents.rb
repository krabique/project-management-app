class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.belongs_to :project, index: true
      t.string :url

      t.timestamps
    end
  end
end
