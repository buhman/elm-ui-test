module Navbar exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Models exposing (Model)
import Messages exposing (..)


navbar : Model -> Html Msg
navbar model =
    nav [ class "navbar has-shadow" ]
        [ div [ class "container" ]
            [ navbarBrand model
            , navbarMenu model
            ]
        ]


navbarBrand : Model -> Html Msg
navbarBrand model =
    div [ class "navbar-brand" ]
        [ a [ class "navbar-item" ]
            [ span [ class "icon pb-logo" ] []
            , h3 [ class "title is-4" ] [ text "ptpb.pw" ]
            ]
        , burger
        ]


navbarMenu : Model -> Html Msg
navbarMenu model =
    let
        navClass =
            case model.menuActive of
                True ->
                    "navbar-menu is-active"

                False ->
                    "navbar-menu"
    in
        div [ class navClass ]
            [ div [ class "navbar-start" ]
                [ a [ class "navbar-item is-active" ] [ text "text" ]
                , a [ class "navbar-item" ] [ text "file" ]
                , a [ class "navbar-item" ] [ text "image" ]
                ]
            , div [ class "navbar-end" ]
                [ a [ class "navbar-item" ]
                    [ span [ class "icon" ]
                        [ i [ class "mdi mdi-github-circle mdi-24px" ] []
                        ]
                    ]
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
