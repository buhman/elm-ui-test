module Pages.Text exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Messages exposing (..)
import Models exposing (Model)
import Pages.Text.HistoryCard exposing (historyCard)


inProgressClass : Bool -> String
inProgressClass inProgress =
    case inProgress of
        True ->
            "is-loading"

        False ->
            ""


inputCard : Bool -> Html Msg
inputCard inProgress =
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


textPage : Model -> Html Msg
textPage model =
    div [ class "columns" ]
        [ div [ class "column" ] [ inputCard model.pasteInProgress ]
        , div [ class "column is-one-quarter" ] [ historyCard model ]
        ]
