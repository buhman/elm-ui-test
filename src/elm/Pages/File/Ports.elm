port module Pages.File.Ports exposing (..)

import Json.Decode as Json
import File exposing (Blob)
import Commands exposing (PasteResponse)


port createFiles : List Blob -> Cmd msg


port createFilesCompleted : (PasteResponse -> msg) -> Sub msg
