// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var ArtistLookup = new Class({
    uid: null,
    artistNames: null,
    userName: null,
    saveDataRequest: null,
    partyId: null,

    initialize: function(partyId) {
        this.partyId = partyId;
        FB.getLoginStatus(this.handleLoginStatus.bind(this));
        this.saveDataRequest = new Request({
            url: "/api/users.json",
            method: "post",
            urlEncoded: false,
            headers: {
                "Content-type": "application/json"
            }
        });
        this.saveDataRequest.onSuccess = this.handleSaveDataSuccess.bind(this);
    },

    doLogin: function(e) {
        e.preventDefault();
        FB.login(this.handleLogin.bind(this), { scope: 'email, user_likes, user_activities'} );
    },

    handleLogin: function(response) {
        console.log("We're logged in now, let's do this.");
        $('connect').addClass("hidden");
        this.handleLoginStatus(response);
    },

    handleLoginStatus: function(response) {
        console.log("Received login status.");
        if (response.status === 'connected') {
            this.uid = response.authResponse.userID;
            FB.api('/me/music', this.handleMusicLikes.bind(this));
            FB.api("/me", this.handleUserData.bind(this));
        } else {
            console.log("Not logged in, waiting for login.");
            $('connect').removeClass("hidden");
            $('connect').addEvent("click", this.doLogin.bind(this))
        }
    },

    handleMusicLikes: function(response) {
        console.log("Received music likes");
        this.artistNames = [];
        response.data.each(function(element) {
            this.artistNames.push(element.name);
        }, this)
        this.finalizeIfDone();
    },

    handleUserData: function(response) {
        console.log("Received user data.");
        this.userName = response.name;
        this.finalizeIfDone();
    },

    handleSaveDataSuccess: function(response) {
        console.log("Saved data successfully");
        console.log(response);
    },

    finalizeIfDone: function() {
        if (!this.uid || !this.artistNames || !this.userName) return;
        console.log("Everything found, sending the data to Smart DJ");
        var requestData = {
            uid: this.uid,
            artists: this.artistNames,
            userName: this.userName,
            partyId: this.partyId
        }
        this.saveDataRequest.send(JSON.encode(requestData));
    }
})