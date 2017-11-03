module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (..)
import Models exposing (Model)
import Notification exposing (notificationList)
import Page exposing (Page(..))
import Pages.Text as Text
import Views.Navbar as Navbar


view : Model -> Html Msg
view model =
    viewPage model model.currentPage


viewFrame : Model -> Page -> Html Msg -> Html Msg
viewFrame model page content =
    div []
        [ Navbar.view page model
        , div [ class "container" ]
            [ content ]
        , notificationList model.notifications
        ]


viewPage : Model -> Page -> Html Msg
viewPage model page =
    let
        frame =
            viewFrame model page
    in
        case page of
            NotFound ->
                Html.text "not found rip"
                    |> frame

            Text ->
                Text.view model
                    |> frame

            _ ->
                Html.text "not implemented"
                    |> frame
