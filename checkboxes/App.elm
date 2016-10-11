import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Html.Attributes exposing (..)

-- MAIN
main =
  App.program 
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

-- INIT
type alias Model =
  { notifications : Bool
  , autoplay : Bool
  , location : Bool
  }

init : (Model, Cmd Msg)
init =
    (Model False False False, Cmd.none)

-- UPDATE
type Msg
  = ToggleNotifications
  | ToggleAutoPlay
  | ToggleLocation

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ToggleNotifications ->
      ({ model | notifications = not model.notifications }, Cmd.none)

    ToggleAutoPlay ->
      ({ model | autoplay = not model.autoplay }, Cmd.none)

    ToggleLocation ->
      ({ model | location = not model.location }, Cmd.none)

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ fieldset []
      [ checkbox ToggleNotifications "Toggle Notifications"
      , checkbox ToggleAutoPlay "Toggle AutoPlay"
      , checkbox ToggleLocation "Toggle Location"
      ]
    ]

checkbox : msg -> String -> Html msg
checkbox msg name =
      label []
      [ input [ type' "checkbox", onClick msg] []
      , text name
      ]

      
-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
