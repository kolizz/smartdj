Smart DJ
Facebook hack stockholm
120308
====






- POST /parties











========== finished / done ================





Party
- name
- users (has many)
- party_tracks (has many)
- party_artists (has many)

User
- name
- fb_uid

PartyTrack
- name
- played_at (datetime)
- party_artists (references :party_artist)
- parties (references :party)

PartyArtist
- name
- counter (integer)
- party_id (t.references :party)