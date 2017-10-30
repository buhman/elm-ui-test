module Panel exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Messages exposing (..)
import Models exposing (Model, PasteResponse)


panel : Model -> Html Msg
panel model =
    let
        pasteItems =
            List.map panelPaste model.pastes
    in
        div [ class "card " ] <|
            List.concat
                [ [ panelHeader model.optionsVisible
                  , panelOptions model.optionsVisible
                  ]
                , pasteItems
                ]


panelOptions : Bool -> Html Msg
panelOptions visible =
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


headerIcon : Bool -> String
headerIcon visible =
    case visible of
        True ->
            "mdi-chevron-down"

        False ->
            "mdi-chevron-up"


panelHeader : Bool -> Html Msg
panelHeader visible =
    header [ class "card-header" ]
        [ a [ class <| "card-footer-item is-active" ]
            [ div [ class "icon" ]
                [ i [ class "mdi mdi-plus-box" ] []
                ]
            , text "new"
            ]
        , a [ class "card-header-icon", onClick ToggleOptionsVisible ]
            [ div [ class "icon" ]
                [ i [ class <| "mdi " ++ headerIcon visible ] []
                ]
            ]
        ]


panelPaste : PasteResponse -> Html Msg
panelPaste paste =
    footer [ class "card-footer" ]
        [ a [ class "card-footer-item", href paste.url ]
            [ div [ class "icon" ]
                [ i [ class <| "mdi mdi-file-document-box" ] []
                ]
            , text paste.short
            ]
        ]
