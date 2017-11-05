port module Pages.File.Ports exposing (..)

import Json.Decode as Json
import File exposing (Blob)


port files : List Blob -> Cmd msg
