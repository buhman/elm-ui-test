module Models exposing (..)

import Page exposing (Page)
import Pages.Text as Text
import Pages.File as File
import Notifications exposing (Notification)


type alias Model =
    { menuActive : Bool
    , notifications : List Notification
    , currentPage : Page
    , textModel : Text.Model
    , fileModel : File.Model
    }
