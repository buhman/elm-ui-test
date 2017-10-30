module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)
import Lorem
import Models exposing (Model, PasteRequest)
import Messages exposing (..)
import Navbar exposing (navbar)
import Panel exposing (panel)
import Commands exposing (createPaste)
import Debug


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }



-- MODEL


init : ( Model, Cmd Msg )
init =
    let
        model =
            Model False "" []

        cmd =
            Cmd.none
    in
        ( model, cmd )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleMenu ->
            ( { model | menuActive = not model.menuActive }
            , Cmd.none
            )

        CreatePaste ->
            ( model
            , createPaste <| PasteRequest model.pasteInput
            )

        PasteCreateDone (Ok paste) ->
            ( { model | pastes = paste :: model.pastes }
            , Cmd.none
            )

        PasteCreateDone (Err err) ->
            ( Debug.crash <| toString err
            , Cmd.none
            )

        PasteInputChange newInput ->
            ( { model | pasteInput = newInput }
            , Cmd.none
            )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Navbar.navbar model
        , div [ class "container" ]
            [ div [ class "columns" ]
                [ div [ class "column" ] [ pasteCard ]
                , div [ class "column is-one-quarter" ] [ panel model.pastes ]
                ]
            ]
        ]


pasteCard : Html Msg
pasteCard =
    div [ class "card" ]
        [ div [ class "card-content" ]
            [ div [ class "field " ]
                [ div [ class "control" ]
                    [ textarea [ class "textarea", rows 20, placeholder "paste content", onInput PasteInputChange ] []
                    ]
                ]
            , div [ class "field" ]
                [ div [ class "control" ]
                    [ button [ class "button is-fullwidth is-primary", onClick CreatePaste ] [ text "create paste" ]
                    ]
                ]
            ]
        ]
