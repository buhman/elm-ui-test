module Messages exposing (..)

import Http
import Models exposing (PasteResponse)


type Msg
    = ToggleMenu
    | PasteCreateDone (Result Http.Error PasteResponse)
    | CreatePaste
    | PasteInputChange String
    | ToggleOptionsVisible
    | RemoveNotification Int
