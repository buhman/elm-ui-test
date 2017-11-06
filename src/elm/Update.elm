module Update exposing (..)

import Http
import Navigation exposing (newUrl)
import Models exposing (..)
import Messages exposing (..)
import Commands exposing (createPaste)
import Route exposing (Route, routeToString)
import Notifications exposing (removeNotification)
import Page exposing (Page)
import Pages.Text as Text
import Pages.File as File


updateRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
updateRoute maybeRoute model =
    case maybeRoute of
        Nothing ->
            ( { model | currentPage = Page.NotFound }
            , Cmd.none
            )

        Just Route.Root ->
            ( model
            , newUrl (routeToString Route.Text)
            )

        Just route ->
            ( { model | currentPage = routeMap route }
            , Cmd.none
            )


routeMap : Route -> Page
routeMap route =
    case route of
        -- this should actually never happen
        Route.Root ->
            Page.Blank

        Route.Text ->
            Page.Text

        Route.File ->
            Page.File

        Route.Image ->
            Page.Image



-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleMenu ->
            ( { model | menuActive = not model.menuActive }
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

        TextMsg subMsg ->
            let
                ( textModel, cmd, maybeNotification ) =
                    Text.update subMsg model.textModel

                newModel =
                    { model | textModel = textModel }

                newCmd =
                    Cmd.map TextMsg cmd
            in
                case maybeNotification of
                    Just notification ->
                        ( { newModel | notifications = notification :: newModel.notifications }
                        , newCmd
                        )

                    Nothing ->
                        ( newModel
                        , newCmd
                        )

        FileMsg subMsg ->
            let
                ( fileModel, cmd ) =
                    File.update subMsg model.fileModel

                newModel =
                    { model | fileModel = fileModel }

                newCmd =
                    Cmd.map FileMsg cmd
            in
                ( newModel
                , newCmd
                )



-- subscriptions


pageSubscriptions : Page -> Sub Msg
pageSubscriptions page =
    case page of
        Page.File ->
            Sub.map FileMsg File.subscriptions

        _ ->
            Sub.none


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ pageSubscriptions model.currentPage
        ]
