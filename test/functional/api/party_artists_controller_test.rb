require 'test_helper'

class Api::PartyArtistsControllerTest < ActionController::TestCase
  setup do
    @party_artist = party_artists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:party_artists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create party_artist" do
    assert_difference('PartyArtist.count') do
      post :create, party_artist: @party_artist.attributes
    end

    assert_redirected_to party_artist_path(assigns(:party_artist))
  end

  test "should show party_artist" do
    get :show, id: @party_artist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @party_artist
    assert_response :success
  end

  test "should update party_artist" do
    put :update, id: @party_artist, party_artist: @party_artist.attributes
    assert_redirected_to party_artist_path(assigns(:party_artist))
  end

  test "should destroy party_artist" do
    assert_difference('PartyArtist.count', -1) do
      delete :destroy, id: @party_artist
    end

    assert_redirected_to party_artists_path
  end
end
