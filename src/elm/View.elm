module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (..)
import Models exposing (Model)
import Navbar exposing (navbar)
import Notification exposing (notificationList)
import Pages.Text exposing (textPage)


view : Model -> Html Msg
view model =
    div []
        [ Navbar.navbar model
        , div [ class "container" ]
            [ textPage model ]
        , notificationList model.notifications
        ]
