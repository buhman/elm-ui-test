module Commands exposing (..)

import Http exposing (jsonBody)
import Json.Encode exposing (Value, string, object)
import Json.Decode as Decode


type alias PasteRequest =
    { content : String
    }


type alias PasteResponse =
    { url : String
    , long : String
    , short : String
    , status : String
    , digest : String
    , date : String
    , size : Int
    }


pasteRequestEncoder : PasteRequest -> Value
pasteRequestEncoder request =
    object
        [ ( "content", string request.content )
        ]


pasteResponseDecoder : Decode.Decoder PasteResponse
pasteResponseDecoder =
    Decode.map7 PasteResponse
        (Decode.field "url" Decode.string)
        (Decode.field "long" Decode.string)
        (Decode.field "short" Decode.string)
        (Decode.field "status" Decode.string)
        (Decode.field "digest" Decode.string)
        (Decode.field "date" Decode.string)
        (Decode.field "size" Decode.int)


post : String -> Http.Body -> Decode.Decoder a -> Http.Request a
post url body decoder =
    Http.request
        { method = "POST"
        , headers = [ Http.header "accept" "application/json" ]
        , url = url
        , body = body
        , expect = Http.expectJson decoder
        , timeout = Nothing
        , withCredentials = False
        }


createPaste : (Result Http.Error PasteResponse -> msg) -> PasteRequest -> Cmd msg
createPaste message paste =
    let
        url =
            "https://ptpb.pw/"

        body =
            jsonBody <| pasteRequestEncoder paste

        request =
            post url body pasteResponseDecoder
    in
        Http.send message request
