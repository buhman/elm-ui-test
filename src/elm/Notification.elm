module Notification exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Messages exposing (..)


notificationList : List String -> Html Msg
notificationList notifications =
    div [ class "notification-container" ]
        [ div [ class "columns" ]
            [ div [ class "column" ] <|
                List.indexedMap notification notifications
            ]
        ]


notification : Int -> String -> Html Msg
notification index notificationText =
    div [ class "notification", onClick (RemoveNotification index) ]
        [ button [ class "delete" ] []
        , text notificationText
        ]
