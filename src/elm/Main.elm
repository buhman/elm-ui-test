module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Lorem
import Models exposing (Model)
import Messages exposing (..)
import Navbar exposing (navbar)
import Panel exposing (panel)


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
    div []
        [ Navbar.navbar model
        , div [ class "container" ]
            [ div [ class "columns" ]
                [ div [ class "column" ] [ pasteCard ]
                , div [ class "column is-one-quarter" ] [ panel ]
                ]
            ]
        ]


pasteCard : Html Msg
pasteCard =
    div [ class "card" ]
        [ div [ class "card-content" ]
            [ div [ class "field " ]
                [ div [ class "control" ]
                    [ textarea [ class "textarea", rows 20, placeholder "paste content" ] []
                    ]
                ]
            , div [ class "field" ]
                [ div [ class "control" ]
                    [ button [ class "button is-fullwidth is-primary" ] [ text "create paste" ]
                    ]
                ]
            ]
        ]
