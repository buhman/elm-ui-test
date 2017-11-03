module Update exposing (..)

import Http
import Navigation exposing (newUrl)
import Models exposing (..)
import Messages exposing (..)
import Commands exposing (createPaste)
import Route exposing (Route, routeToString)
import Page exposing (Page)
import Debug


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


updateRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
updateRoute maybeRoute model =
    case maybeRoute of
        Nothing ->
            ( { model | currentPage = Page.NotFound }
            , Cmd.none
            )

        Just route ->
            ( { model | currentPage = routeMap route }
            , Cmd.none
            )


routeMap : Route -> Page
routeMap route =
    case route of
        Route.Text ->
            Page.Text

        Route.File ->
            Page.File

        Route.Image ->
            Page.Image


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

        SetRoute route ->
            ( model
            , newUrl (routeToString route)
            )

        UrlChange maybeRoute ->
            updateRoute maybeRoute model
