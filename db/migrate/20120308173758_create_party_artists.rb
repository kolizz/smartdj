class CreatePartyArtists < ActiveRecord::Migration
  def change
    create_table :party_artists do |t|
      t.string :name
      t.integer :count
      t.references :party

      t.timestamps
    end
  end
end
