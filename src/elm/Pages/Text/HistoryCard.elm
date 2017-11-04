module Pages.Text.HistoryCard exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Commands exposing (PasteResponse)


historyCard : msg -> List PasteResponse -> Bool -> Html msg
historyCard toggleMessage pastes optionsVisible =
    let
        pasteItems =
            List.map cardPaste pastes
    in
        div [ class "card " ] <|
            List.concat
                [ [ cardHeader toggleMessage optionsVisible
                  , cardOptions optionsVisible
                  ]
                , pasteItems
                ]


cardOptions : Bool -> Html msg
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


cardHeader : msg -> Bool -> Html msg
cardHeader toggleMessage visible =
    header [ class "card-header" ]
        [ a [ class <| "card-footer-item is-active" ]
            [ div [ class "icon" ]
                [ i [ class "mdi mdi-plus-box" ] []
                ]
            , text "new"
            ]
        , a [ class "card-header-icon", onClick toggleMessage ]
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


cardPaste : PasteResponse -> Html msg
cardPaste paste =
    footer [ class "card-footer" ]
        [ a [ class "card-footer-item", href paste.url ]
            [ div [ class "icon" ]
                [ i [ class <| "mdi mdi-file-document-box" ] []
                ]
            , text paste.short
            ]
        ]
