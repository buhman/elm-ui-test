module Panel exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (..)
import Models exposing (PasteResponse)


panel : List PasteResponse -> Html Msg
panel pastes =
    let
        pasteItems =
            List.map (\paste -> panelPaste paste.short "") pastes
    in
        div [ class "card" ]
            (panelHeader "new" "is-active" :: pasteItems)


panelHeader : String -> String -> Html Msg
panelHeader pasteText blockClass =
    header [ class "card-header" ]
        [ a [ class <| "card-footer-item " ++ blockClass ]
            [ div [ class "icon" ]
                [ i [ class "mdi mdi-plus-box" ] []
                ]
            , text pasteText
            ]
        , a [ class "card-header-icon" ]
            [ div [ class "icon" ]
                [ i [ class "mdi mdi-chevron-down" ] []
                ]
            ]
        ]


panelPaste : String -> String -> Html Msg
panelPaste pasteText blockClass =
    footer [ class "card-footer" ]
        [ a [ class <| "card-footer-item " ++ blockClass ]
            [ div [ class "icon" ]
                [ i [ class <| "mdi mdi-file-document-box" ] []
                ]
            , text pasteText
            ]
        ]
