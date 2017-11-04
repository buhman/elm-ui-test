module Notification exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Messages exposing (..)
import Notifications exposing (Notification, Level(..))


notificationList : List Notification -> Html Msg
notificationList notifications =
    div [ class "notification-container" ]
        [ div [ class "columns" ]
            [ div [ class "column" ] <|
                List.indexedMap notification notifications
            ]
        ]


notificationIcon : Level -> String
notificationIcon level =
    case level of
        Danger ->
            "mdi mdi-close-circle has-text-danger"

        Success ->
            "mdi mdi-check-circle has-text-success"

        Warning ->
            "mdi mdi-alert-circle has-text-warning"

        Info ->
            "mdi mdi-information has-text-info"


notification : Int -> Notification -> Html Msg
notification index notification =
    div [ class "notification", onClick (RemoveNotification index) ]
        [ span [ class "icon" ]
            [ i [ class <| notificationIcon notification.level ] []
            ]
        , strong [ class "inline-title" ] [ text notification.title ]
        , code [] [ text notification.description ]
        ]
