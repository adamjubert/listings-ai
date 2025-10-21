class CreateListingSummaries < ActiveRecord::Migration[8.0]
  def change
    create_table :listing_summaries do |t|
      t.timestamps
      t.references :listing, null: false, foreign_key: true
      t.jsonb :metadata, null: false, default: {}
    end
  end
end
