module Update exposing (..)

import Models exposing (Model, PasteRequest)
import Messages exposing (..)
import Commands exposing (createPaste)
import Debug


removeNotification : Int -> List String -> List String
removeNotification index notifications =
    (List.take index notifications) ++ (List.drop (index + 1) notifications)


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
            ( { model
                | pastes = paste :: model.pastes
                , pasteInProgress = False
              }
            , Cmd.none
            )

        PasteCreateDone (Err err) ->
            ( { model
                | notifications = (toString err) :: model.notifications
                , pasteInProgress = False
              }
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

        RemoveNotification index ->
            ( { model | notifications = removeNotification index model.notifications }
            , Cmd.none
            )
