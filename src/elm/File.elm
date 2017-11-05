module File exposing (..)

import Json.Decode as Json exposing (Value, Decoder)
import Json.Decode.Extra as JsonExtra


type alias Blob =
    Value


type alias File =
    { lastModified : Int
    , name : String
    , size : Int
    , mimetype : String
    , blob : Blob
    }


targetFiles : Decoder (List File)
targetFiles =
    Json.at [ "target", "files" ] <|
        JsonExtra.collection fileDecoder


fileDecoder : Decoder File
fileDecoder =
    Json.map5 File
        (Json.field "lastModified" Json.int)
        (Json.field "name" Json.string)
        (Json.field "size" Json.int)
        (Json.field "type" Json.string)
        Json.value
