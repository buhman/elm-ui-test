module Pages.File exposing (..)

import Html exposing (Html, div, button, label, input, i, text, span, table, tbody, thead, tr, td, th)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue, onClick)
import Json.Decode as Json
import Pages.File.Ports as Ports
import File exposing (targetFiles, File)
import Commands exposing (PasteResponse)


-- MODEL


type alias Model =
    { files : List File
    , input : String
    , inProgress : Bool
    , pastes : List PasteResponse
    }


initNew : Model
initNew =
    { files = []
    , input = "none"
    , inProgress = False
    , pastes = []
    }



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "card" ]
        [ div [ class "card-content" ]
            [ div [ class "field" ]
                [ fileInput model.files
                ]
            , div [ class "field" ]
                [ div [ class "control" ]
                    [ button
                        [ class "button is-fullwidth is-primary"
                        , classList [ ( "is-loading", model.inProgress ) ]
                        , onClick CreateFiles
                        ]
                        [ text "create paste" ]
                    ]
                ]
            ]
        ]


fileInput : List File -> Html Msg
fileInput files =
    div [ class "file has-name is-boxed is-fullwidth" ]
        [ label [ class "file-label" ]
            [ input
                [ class "file-input"
                , type_ "file"

                -- fixme
                , multiple False
                , on "change" (Json.map SetFiles targetFiles)
                ]
                []
            , span [ class "file-cta" ]
                [ span [ class "file-icon" ]
                    [ i [ class "mdi mdi-upload" ] []
                    ]
                , span [ class "file-label" ] [ text "Choose a file…" ]
                ]
            , div [ class "file-table" ]
                [ table [ class "table is-fullwidth is-responsive" ] <|
                    fileLabels files
                ]
            ]
        ]


fileLabels : List File -> List (Html Msg)
fileLabels files =
    case files of
        [] ->
            [ span [ class "file-table-label" ] [ text "no file selected" ] ]

        _ ->
            (List.map fileLabel files)


fileLabel : File -> Html Msg
fileLabel file =
    tbody []
        [ tr []
            [ th [] [ text "name" ]
            , td [] [ text file.name ]
            ]
        , tr
            []
            [ th [] [ text "size" ]
            , td [] [ text <| toString file.size ]
            ]
        , tr
            []
            [ th [] [ text "mimetype" ]
            , td [] [ text file.mimetype ]
            ]
        ]



-- UPDATE


type Msg
    = SetFiles (List File)
    | CreateFiles
    | CreateFilesCompleted PasteResponse


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetFiles files ->
            ( { model | files = files }
            , Cmd.none
            )

        CreateFiles ->
            ( { model | inProgress = True }
            , Ports.createFiles <| List.map (\file -> file.blob) model.files
            )

        CreateFilesCompleted paste ->
            ( { model
                | inProgress = False
                , pastes = paste :: model.pastes
                , files = []
              }
            , Cmd.none
            )



-- Subscriptions


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ Ports.createFilesCompleted CreateFilesCompleted
        ]
