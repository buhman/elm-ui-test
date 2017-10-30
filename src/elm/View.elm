module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)
import Models exposing (Model)
import Messages exposing (..)
import Navbar exposing (navbar)
import Panel exposing (panel)


view : Model -> Html Msg
view model =
    div []
        [ Navbar.navbar model
        , div [ class "container" ]
            [ div [ class "columns" ]
                [ div [ class "column" ] [ pasteCard model.pasteInProgress ]
                , div [ class "column is-one-quarter" ] [ panel model.pastes ]
                ]
            ]
        ]


inProgressClass : Bool -> String
inProgressClass inProgress =
    case inProgress of
        True ->
            "is-loading"

        False ->
            ""


pasteCard : Bool -> Html Msg
pasteCard inProgress =
    div [ class "card" ]
        [ div [ class "card-content" ]
            [ div [ class "field " ]
                [ div [ class "control" ]
                    [ textarea
                        [ class "textarea"
                        , rows 20
                        , placeholder "paste content"
                        , onInput PasteInputChange
                        ]
                        []
                    ]
                ]
            , div [ class "field" ]
                [ div [ class "control" ]
                    [ button
                        [ class <| "button is-fullwidth is-primary " ++ inProgressClass inProgress
                        , onClick CreatePaste
                        ]
                        [ text "create paste" ]
                    ]
                ]
            ]
        ]
