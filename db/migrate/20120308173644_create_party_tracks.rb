class CreatePartyTracks < ActiveRecord::Migration
  def change
    create_table :party_tracks do |t|
      t.string :name
      t.datetime :played_at
      t.references :party_artist
      t.references :party

      t.timestamps
    end
  end
end
