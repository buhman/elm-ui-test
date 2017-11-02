module Pages.Text.HistoryCard exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Messages exposing (..)
import Models exposing (Model, PasteResponse)


historyCard : Model -> Html Msg
historyCard model =
    let
        pasteItems =
            List.map cardPaste model.pastes
    in
        div [ class "card " ] <|
            List.concat
                [ [ cardHeader model.optionsVisible
                  , cardOptions model.optionsVisible
                  ]
                , pasteItems
                ]


cardOptions : Bool -> Html Msg
cardOptions visible =
    div
        [ class "card-content", hidden (not visible) ]
        [ div [ class "field" ]
            [ div [ class "control" ]
                [ label [ class "checkbox" ]
                    [ input [ type_ "checkbox" ] []
                    , text " private"
                    ]
                ]
            ]
        ]


cardHeader : Bool -> Html Msg
cardHeader visible =
    header [ class "card-header" ]
        [ a [ class <| "card-footer-item is-active" ]
            [ div [ class "icon" ]
                [ i [ class "mdi mdi-plus-box" ] []
                ]
            , text "new"
            ]
        , a [ class "card-header-icon", onClick ToggleOptionsVisible ]
            [ div [ class "icon" ]
                [ i
                    [ classList
                        [ ( "mdi", True )
                        , ( "mdi-chevron-up", visible )
                        , ( "mdi-chevron-down", (not visible) )
                        ]
                    ]
                    []
                ]
            ]
        ]


cardPaste : PasteResponse -> Html Msg
cardPaste paste =
    footer [ class "card-footer" ]
        [ a [ class "card-footer-item", href paste.url ]
            [ div [ class "icon" ]
                [ i [ class <| "mdi mdi-file-document-box" ] []
                ]
            , text paste.short
            ]
        ]
