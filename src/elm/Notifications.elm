module Notifications exposing (..)

import Http
import Commands exposing (PasteResponse)


type Level
    = Danger
    | Success
    | Warning
    | Info


type alias Notification =
    { title : String
    , description : String
    , level : Level
    }



-- Helpers for notifications


removeNotification : Int -> List Notification -> List Notification
removeNotification index notifications =
    (List.take index notifications) ++ (List.drop (index + 1) notifications)


notificationError : Http.Error -> Notification
notificationError error =
    case error of
        Http.BadStatus response ->
            Notification "api error" (response.body) Danger

        error ->
            Notification "error" (toString error) Danger


notificationPaste : PasteResponse -> Notification
notificationPaste paste =
    Notification "success" paste.status Success
