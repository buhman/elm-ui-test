module Notifications exposing (..)

import Http
import Commands exposing (PasteResponse)
import Pages.File.Ports exposing (FetchError(..))


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


notificationFetchError : FetchError -> Notification
notificationFetchError error =
    case error of
        ApiError message ->
            Notification "api error" (message) Danger

        NetworkError message ->
            Notification "network error" (message) Danger


notificationPaste : PasteResponse -> Notification
notificationPaste paste =
    Notification "success" paste.status Success
