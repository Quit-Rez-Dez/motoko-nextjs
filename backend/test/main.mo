import Principal "mo:base/Principal";



import HashMap "mo:base/HashMap";



import Result "mo:base/Result";
import Bool "mo:base/Bool";
import List "mo:base/List";
import Debug "mo:base/Debug";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Time "mo:base/Time";
import Nat  "mo:base/Nat";
import Int  "mo:base/Int";

//importamos stable hashmap que de la docu de motoko 
//https://github.com/ClankPan/StableHashMap/tree/master/src/StableHashMap

import StableHashMap "/StableHashMap";

actor {



    /* 
        Creamo variable stable4 para mantener los registros
    */
    var stableHashMap = StableHashMap.HashMap<Text, Nat>(1, Text.equal, Text.hash);
    stable var stableVars = stableHashMap.exportVars();


    //ejemplo para insertar de stablehashmap 
    public func put(name : Text, value : Nat) : async Text {
        stableHashMap.put(name, value);
        return name;
    };


    /*
     preupgrade obtiene data anteriori
     post modifica el hashmap
    */
    system func preupgrade() {
        stableVars := stableHashMap.exportVars();
    };
    system func postupgrade() {
        stableHashMap := StableHashMap.HashMap<Text, Nat>(1, Text.equal, Text.hash);
        stableHashMap.importVars(stableVars);
    };

    type Registros = {
        username : Text;
        movimiento : Text;
        fecha_movimiento : Int;
    };


     
    type GetRegistroError = {
        #userNotAuthenticated;
        #profileNotFound;
    };

  
    type CreateRegistroError = {
        #profileAlreadyExists;
        #userNotAuthenticated;
    };

    type CreateRegistroResponse = Result.Result<Bool, CreateRegistroError>;

 

    //obtener todos los valores
    public query func getAllValues() : async [(Text, Registros)] {
        let entriesIter = stableLogs.entries();
        let entriesArray = Iter.toArray(entriesIter);
        return entriesArray;
    };

    //variables para insertar los logs
    var stableLogs = StableHashMap.HashMap<Text, Registros>(1, Text.equal, Text.hash);
    stable var stableVarsLogs = stableLogs.exportVars();

    public shared ({ caller }) func insertarLog(username : Text, movimiento : Text) : async CreateRegistroResponse {

        let newProfile : Registros = {
            username = username;
            movimiento = movimiento;
            fecha_movimiento = Time.now();
        };

        stableLogs.put(Int.toText(Time.now()), newProfile);

        #ok(true);
    };

 

   

};
