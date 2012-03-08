require 'test_helper'

class PartyTracksControllerTest < ActionController::TestCase
  setup do
    @party_track = party_tracks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:party_tracks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create party_track" do
    assert_difference('PartyTrack.count') do
      post :create, party_track: @party_track.attributes
    end

    assert_redirected_to party_track_path(assigns(:party_track))
  end

  test "should show party_track" do
    get :show, id: @party_track
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @party_track
    assert_response :success
  end

  test "should update party_track" do
    put :update, id: @party_track, party_track: @party_track.attributes
    assert_redirected_to party_track_path(assigns(:party_track))
  end

  test "should destroy party_track" do
    assert_difference('PartyTrack.count', -1) do
      delete :destroy, id: @party_track
    end

    assert_redirected_to party_tracks_path
  end
end
