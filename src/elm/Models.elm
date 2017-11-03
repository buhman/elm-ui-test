module Models exposing (..)

import Page exposing (Page)


type alias Model =
    { menuActive : Bool
    , pasteInput : String
    , pastes : List PasteResponse
    , pasteInProgress : Bool
    , optionsVisible : Bool
    , notifications : List Notification
    , currentPage : Page
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


type alias Notification =
    { title : String
    , description : String
    , level : Level
    }


type Level
    = Danger
    | Success
    | Warning
    | Info
