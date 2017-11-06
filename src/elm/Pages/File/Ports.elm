port module Pages.File.Ports exposing (..)

import Json.Decode as Json
import File exposing (Blob)
import Commands exposing (PasteResponse, pasteResponseDecoder)
import Http
import Debug


type FetchError
    = ApiError String
    | NetworkError String


port createFiles : List Blob -> Cmd msg


port createFilesCompleted : (Json.Value -> msg) -> Sub msg


fetchError =
    Json.field "type" Json.string
        |> Json.andThen fetchErrorHelp


fetchErrorHelp errorType =
    case errorType of
        "network" ->
            Json.map NetworkError (Json.field "error" Json.string)

        "api" ->
            Json.map ApiError (Json.field "error" Json.string)

        _ ->
            Json.fail ("unsupported error type: " ++ errorType)


fetchResult =
    Json.oneOf
        [ Json.map Err fetchError
        , Json.map Ok pasteResponseDecoder
        ]


decodeFetchResult : Json.Value -> Result FetchError PasteResponse
decodeFetchResult value =
    let
        result =
            Json.decodeValue fetchResult value
    in
        case result of
            Ok fetchResult ->
                fetchResult

            Err error ->
                Debug.crash "decodeFetchResult" error
