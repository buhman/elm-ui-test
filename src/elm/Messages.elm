module Messages exposing (..)

import Http
import Models exposing (PasteResponse)
import Route exposing (Route)


type Msg
    = ToggleMenu
    | PasteCreateDone (Result Http.Error PasteResponse)
    | CreatePaste
    | PasteInputChange String
    | ToggleOptionsVisible
    | RemoveNotification Int
    | UrlChange (Maybe Route)
    | SetRoute Route
