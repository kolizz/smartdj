class CreatePartyArtists < ActiveRecord::Migration
  def change
    create_table :party_artists do |t|
      t.string :name
      t.references :user

      t.timestamps
    end
  end
end
