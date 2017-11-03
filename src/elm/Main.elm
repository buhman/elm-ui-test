module Main exposing (..)

import Html
import Navigation exposing (Location)
import Models exposing (Model)
import Messages exposing (Msg, Msg(UrlChange))
import Update exposing (update, updateRoute)
import View exposing (view)
import Route exposing (fromLocation)
import Page exposing (Page)


main =
    Navigation.program (fromLocation >> UrlChange)
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }



-- INIT


init : Location -> ( Model, Cmd Msg )
init location =
    let
        model =
            Model False "" [] False False [] Page.Blank
    in
        updateRoute (fromLocation location) model
