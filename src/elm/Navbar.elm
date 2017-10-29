module Navbar exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)

import Models exposing (Model)
import Messages exposing (..)


navbar : Model -> Html Msg
navbar model =
    nav [ class "navbar" ]
        [ navbarBrand
        , navbarMenu model
        ]


navbarBrand : Html Msg
navbarBrand =
    div [ class "navbar-brand" ]
        [ a [ class "navbar-item" ] [ text "branding" ]
        , burger
        ]


navbarMenu : Model -> Html Msg
navbarMenu model =
    let
        navClass =
            case model.menuActive of
                True -> "navbar-menu is-active"
                False -> "navbar-menu"
    in
        div [ class navClass ]
            [ div [ class "navbar-item has-dropdown is-hoverable" ]
                [ a [ class "navbar-link" ] [ text "Dashboard" ]
                , dropdown
                ]
            , div [ class "navbar-item has-dropdown is-hoverable" ]
                [ a [ class "navbar-link" ] [ text "Services" ]
                , dropdown
                ]
            ]


dropdown : Html Msg
dropdown =
    div [ class "navbar-dropdown" ]
        [ a [ class "navbar-item" ] [ text "Dropdown 1" ]
        , a [ class "navbar-item" ] [ text "Dropdown 5" ]
        ]


burger : Html Msg
burger =
    div [ class "navbar-burger burger", onClick ToggleMenu ]
        [ span [] []
        , span [] []
        , span [] []
        ]
