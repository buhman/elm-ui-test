module Route exposing (..)

import Navigation exposing (Location)
import UrlParser as Url exposing ((</>), Parser, oneOf, s, parsePath)
import Html exposing (Attribute)
import Html.Attributes as Attr


type Route
    = Text
    | File
    | Image


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Text (s "text")
        , Url.map File (s "file")
        , Url.map Image (s "image")
        ]


routeToString : Route -> String
routeToString page =
    let
        pieces =
            case page of
                Text ->
                    [ "text" ]

                File ->
                    [ "file" ]

                Image ->
                    [ "image" ]
    in
        String.join "/" pieces


href : Route -> Attribute msg
href route =
    Attr.href (routeToString route)


fromLocation : Location -> Maybe Route
fromLocation location =
    parsePath route location
