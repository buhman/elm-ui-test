module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Lorem

import Models exposing (Model)
import Messages exposing (..)
import Navbar exposing (navbar)


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }


-- MODEL

model : Model
model =
    Model False


-- UPDATE

update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleMenu ->
            { model | menuActive = not model.menuActive }


-- VIEW

view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "columns" ]
            [ div [ class "column is-one-quarter" ] []
            , div [ class "column" ] [ Navbar.navbar model ]
            ]
        , div [ class "columns" ]
            [ div [ class "column is-one-quarter" ] [ sidebar ]
            , div [ class "column" ] [ card ]
            ]
        ]


sidebar : Html Msg
sidebar =
    nav [ class "panel" ]
        [ a [ class "panel-block is-active"] [ text "test1" ]
        , a [ class "panel-block is-active"] [ text "test2" ]
        ]

card : Html Msg
card =
    div [ class "card" ]
        [ header [ class "card-header" ]
            [ p [ class "card-header-title" ] [ text "Card Title" ]
            ]
        , div [ class "card-content" ]
            [ div [ class "content" ] <| paragraphs 2
            ]
        ]


paragraphs : Int -> List (Html Msg)
paragraphs number =
    let
        makeParagraph content =
            p [] [ text content ]
    in
        List.map makeParagraph <| Lorem.paragraphs number


icon : String -> List String -> Html Msg
icon iconName extra =
    let
        iconClass =
            String.join " " ("icon" :: extra)

        mdiClass =
            "mdi mdi-" ++ iconName

    in
        span [ class iconClass ]
            [ i [ class mdiClass ] []
            ]
