module Messages exposing (..)

import Route exposing (Route)
import Pages.Text as Text
import Pages.File as File


type Msg
    = ToggleMenu
    | RemoveNotification Int
    | UrlChange (Maybe Route)
    | SetRoute Route
    | TextMsg Text.Msg
    | FileMsg File.Msg
