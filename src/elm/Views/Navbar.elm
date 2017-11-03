module Views.Navbar exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Models exposing (Model)
import Messages exposing (..)
import Route exposing (Route)
import Page exposing (Page)
import Util exposing (onPreventDefaultClick)


view : Page -> Model -> Html Msg
view currentPage model =
    nav [ class "navbar has-shadow" ]
        [ div [ class "container" ]
            [ navbarBrand
            , navbarMenu currentPage model
            ]
        ]


navbarBrand : Html Msg
navbarBrand =
    div [ class "navbar-brand" ]
        [ a [ class "navbar-item" ]
            [ span [ class "icon pb-logo" ] []
            , h3 [ class "title is-4" ] [ text "ptpb.pw" ]
            ]
        , burger
        ]


navbarMenu : Page -> Model -> Html Msg
navbarMenu currentPage model =
    div
        [ classList
            [ ( "navbar-menu", True )
            , ( "is-active", model.menuActive )
            ]
        ]
        [ div [ class "navbar-start" ]
            [ navbarLink currentPage Route.Text "text"
            , navbarLink currentPage Route.File "file"
            , navbarLink currentPage Route.Image "image"
            ]
        , div [ class "navbar-end" ]
            [ a [ class "navbar-item" ]
                [ span [ class "icon" ]
                    [ i [ class "mdi mdi-github-circle mdi-24px" ] []
                    ]
                ]
            ]
        ]


navbarLink : Page -> Route -> String -> Html Msg
navbarLink currentPage route linkText =
    a
        [ classList
            [ ( "navbar-item", True )
            , ( "is-active", isActive currentPage route )
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



{-
   Not every page has a navbar link, so this maps navbar links
   to pages
-}


isActive : Page -> Route -> Bool
isActive page route =
    case ( page, route ) of
        ( Page.Text, Route.Text ) ->
            True

        ( Page.File, Route.File ) ->
            True

        ( Page.Image, Route.Image ) ->
            True

        _ ->
            False
