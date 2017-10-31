module Update exposing (..)

import Http
import Models exposing (..)
import Messages exposing (..)
import Commands exposing (createPaste)


removeNotification : Int -> List Notification -> List Notification
removeNotification index notifications =
    (List.take index notifications) ++ (List.drop (index + 1) notifications)


createNotificationError : Http.Error -> Notification
createNotificationError error =
    case error of
        Http.BadStatus response ->
            Notification "api error" (response.body) Danger

        error ->
            Notification "error" (toString error) Danger


createNotificationPaste : PasteResponse -> Notification
createNotificationPaste paste =
    Notification "success" paste.status Success


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
                , notifications = (createNotificationPaste paste) :: model.notifications
                , pasteInProgress = False
              }
            , Cmd.none
            )

        PasteCreateDone (Err error) ->
            ( { model
                | notifications = (createNotificationError error) :: model.notifications
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
