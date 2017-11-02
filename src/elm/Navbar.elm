module Navbar exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Models exposing (Model)
import Messages exposing (..)
import Route exposing (Route)
import Util exposing (onPreventDefaultClick)


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
    div
        [ classList
            [ ( "navbar-menu", True )
            , ( "is-active", model.menuActive )
            ]
        ]
        [ div [ class "navbar-start" ]
            [ navbarLink model.currentRoute Route.Text "text"
            , navbarLink model.currentRoute Route.File "file"
            , navbarLink model.currentRoute Route.Image "image"
            ]
        , div [ class "navbar-end" ]
            [ a [ class "navbar-item" ]
                [ span [ class "icon" ]
                    [ i [ class "mdi mdi-github-circle mdi-24px" ] []
                    ]
                ]
            ]
        ]


navbarLink : Route -> Route -> String -> Html Msg
navbarLink currentRoute route linkText =
    a
        [ classList
            [ ( "navbar-item", True )
            , ( "is-active", currentRoute == route )
            ]
        , Route.href route
        , onPreventDefaultClick (SetRoute route)
        ]
        [ text linkText ]


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
