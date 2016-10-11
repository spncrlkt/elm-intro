












import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
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
  = Input String
  | Send
  | NewMessage String

update : Msg -> Model -> (Model, Cmd Msg)
update msg {input, messages} = 
  case msg of
    Input newInput ->
      (Model newInput messages, Cmd.none)

    Send ->
      (Model "" messages, WebSocket.send "ws://echo.websocket.org" input)

    NewMessage newMsg ->
      (Model input (newMsg :: messages), Cmd.none)

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model  =
  WebSocket.listen "ws://echo.websocket.org" NewMessage


-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ input [ onInput Input ] [ text model.input ]
    , button [ onClick Send ] [ text "Send" ]
    , div [] (List.map viewMessage model.messages)
    ]

viewMessage : String -> Html msg
viewMessage msg =
  div [] [ text msg ]
