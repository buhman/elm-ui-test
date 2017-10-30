module Models exposing (..)


type alias Model =
    { menuActive : Bool
    , pasteInput : String
    , pastes : List PasteResponse
    , pasteInProgress : Bool
    , optionsVisible : Bool
    , notifications : List String
    }


type alias PasteRequest =
    { content : String
    }


type alias PasteResponse =
    { url : String
    , long : String
    , short : String
    , status : String
    , digest : String
    , date : String
    , size : Int
    }
