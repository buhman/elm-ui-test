module Messages exposing (..)

import Route exposing (Route)
import Pages.Text as Text


type Msg
    = ToggleMenu
    | RemoveNotification Int
    | UrlChange (Maybe Route)
    | SetRoute Route
    | TextMsg Text.Msg
