class CreateUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :urls do |t|
      t.string :short_version
      t.string :full_version
      t.integer :request_counter, default: 0
    end

    add_index :urls, :short_version, unique: true
    add_index :urls, :full_version, unique: true
  end
end
