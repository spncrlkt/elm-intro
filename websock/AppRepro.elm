import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import WebSocket

-- MAIN
main =
  App.program
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


-- MODEL
type alias Model =
  { input : String
  , messages : List String
  }

init : (Model, Cmd Msg)
init =
  (Model "" [], Cmd.none)


-- UPDATE
type Msg
  = Send
  | NewInput String
  | NewMessage String

update : Msg -> Model -> (Model, Cmd Msg)
update msg {input, messages} =
  case msg of
    Send ->
      (Model "" messages, WebSocket.send "ws://echo.websocket.org" input)

    NewInput newInput ->
      (Model newInput messages, Cmd.none)

    NewMessage newMsg ->
      (Model input (newMsg :: messages), Cmd.none)


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen "ws://echo.websocket.org" NewMessage

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ input [onInput NewInput] []
    , button [onClick Send] [text "SHIPIT"]
    , div [] (List.map viewMessage model.messages)
    ]

viewMessage : String -> Html msg
viewMessage msg =
  div [] [text msg]
