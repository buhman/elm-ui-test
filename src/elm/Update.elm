module Update exposing (..)

import Models exposing (Model, PasteRequest)
import Messages exposing (..)
import Commands exposing (createPaste)
import Debug


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleMenu ->
            ( { model | menuActive = not model.menuActive }
            , Cmd.none
            )

        CreatePaste ->
            ( { model | pasteInProgress = True }
            , createPaste <| PasteRequest model.pasteInput
            )

        PasteCreateDone (Ok paste) ->
            ( { model | pastes = paste :: model.pastes, pasteInProgress = False }
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

        ToggleOptionsVisible ->
            ( { model | optionsVisible = not model.optionsVisible }
            , Cmd.none
            )
