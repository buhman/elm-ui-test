module Main exposing (..)

import Html
import Models exposing (Model)
import Messages exposing (Msg)
import Update exposing (update)
import View exposing (view)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }



-- INIT


init : ( Model, Cmd Msg )
init =
    let
        model =
            Model False "" [] False False

        cmd =
            Cmd.none
    in
        ( model, cmd )
