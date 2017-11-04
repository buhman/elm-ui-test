module Pages.Text exposing (..)

import Http
import Html exposing (Html, div, button, textarea, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Commands exposing (createPaste, PasteResponse, PasteRequest)
import Notifications exposing (notificationError, notificationPaste, Notification)
import Pages.Text.HistoryCard exposing (historyCard)


-- MODEL


type alias Model =
    { input : String
    , pastes : List PasteResponse
    , inProgress : Bool
    , optionsVisible : Bool
    }


initNew : Model
initNew =
    { input = ""
    , pastes = []
    , inProgress = False
    , optionsVisible = False
    }



-- VIEW


view : Model -> Html Msg
view model =
    let
        input =
            inputCard
                model.inProgress

        history =
            historyCard
                ToggleVisible
                model.pastes
                model.optionsVisible
    in
        div [ class "columns" ]
            [ div [ class "column" ] [ input ]
            , div [ class "column is-one-quarter" ] [ history ]
            ]


inputCard : Bool -> Html Msg
inputCard inProgress =
    div [ class "card" ]
        [ div [ class "card-content" ]
            [ div [ class "field " ]
                [ div [ class "control" ]
                    [ textarea
                        [ class "textarea"
                        , rows 20
                        , placeholder "paste content"
                        , onInput SetInput
                        ]
                        []
                    ]
                ]
            , div [ class "field" ]
                [ div [ class "control" ]
                    [ button
                        [ class "button is-fullwidth is-primary"
                        , classList [ ( "is-loading", inProgress ) ]
                        , onClick CreatePaste
                        ]
                        [ text "create paste" ]
                    ]
                ]
            ]
        ]



-- UPDATE


type Msg
    = CreatePaste
    | CreatePasteCompleted (Result Http.Error PasteResponse)
    | SetInput String
    | ToggleVisible


update : Msg -> Model -> ( Model, Cmd Msg, Maybe Notification )
update msg model =
    case msg of
        CreatePaste ->
            ( { model | inProgress = True }
            , createPaste CreatePasteCompleted <| PasteRequest model.input
            , Nothing
            )

        CreatePasteCompleted (Ok paste) ->
            ( { model
                | pastes = paste :: model.pastes
                , inProgress = False
              }
            , Cmd.none
            , Just (notificationPaste paste)
            )

        CreatePasteCompleted (Err error) ->
            ( { model | inProgress = False }
            , Cmd.none
            , Just (notificationError error)
            )

        SetInput input ->
            ( { model | input = input }
            , Cmd.none
            , Nothing
            )

        ToggleVisible ->
            ( { model | optionsVisible = not model.optionsVisible }
            , Cmd.none
            , Nothing
            )
