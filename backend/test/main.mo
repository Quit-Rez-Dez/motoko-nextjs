import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Result "mo:base/Result";
import Bool "mo:base/Bool";
import List "mo:base/List";
import Debug "mo:base/Debug";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Iter "mo:base/Iter";

import StableHashMap "/StableHashMap";



actor {


  var stableHashMap = StableHashMap.HashMap<Text, Nat>(1, Text.equal, Text.hash);
    stable var stableVars = stableHashMap.exportVars();


    public func put(name : Text, value : Nat) : async Text {
        stableHashMap.put(name, value);
        return name;
    };

    type Key = Text;
    type Value = Nat;





public query func getAllValues(): async [(Text, Nat)] {
    let entriesIter = stableHashMap.entries();
    let entriesArray = Iter.toArray(entriesIter);
    return entriesArray;
};



    system func preupgrade() {
        stableVars := stableHashMap.exportVars();
    };

    system func postupgrade() {
        stableHashMap := StableHashMap.HashMap<Text, Nat>(1, Text.equal, Text.hash);
        stableHashMap.importVars(stableVars);
    };


    type Timestamp = Nat64;
    
    type Registros={
        username: Text;
        movimiento:Text;
        fecha_movimiento:Timestamp;
    };


    type Profile = {
        username : Text;
        bio : Text;
    };

    type GetProfileError = {
        #userNotAuthenticated;
        #profileNotFound;
    };

    type GetProfileResponse = Result.Result<Profile, GetProfileError>;

    type CreateProfileError = {
        #profileAlreadyExists;
        #userNotAuthenticated;
    };

    type CreateProfileResponse = Result.Result<Bool, CreateProfileError>;

    let profiles = HashMap.HashMap<Principal, Profile>(0, Principal.equal, Principal.hash);

    public query ({ caller }) func getProfile() : async GetProfileResponse {
        //if (Principal.isAnonymous(caller)) return #err(#userNotAuthenticated);

        let profile = profiles.get(caller);

        switch profile {
            case (?profile) {
                #ok(profile);
            };
            case null {
                #err(#profileNotFound);
            };
        };
    };

    public shared ({ caller }) func createProfile(username : Text, bio : Text) : async CreateProfileResponse {
        //if (Principal.isAnonymous(caller)) return #err(#userNotAuthenticated);

        let profile = profiles.get(caller);

        if (profile != null) return #err(#profileAlreadyExists);

        let newProfile : Profile = {
            username = username;
            bio = bio;
        };

        profiles.put(caller, newProfile);

        #ok(true);
    };


   
};
