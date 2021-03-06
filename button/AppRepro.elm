import Html exposing (Html, div, button, text)
import Html.App as App
import Html.Events exposing (onClick)

main = 
  App.beginnerProgram
    { model = model
    , update = update
    , view = view
    }

-- MODEL

type alias Model = Int

model : Model
model = 
  0

-- UPDATE
type Msg = Increment | Decrement | Reset

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

    Reset ->
      0

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick Increment ] [ text "+" ]
    , button [ onClick Reset ] [ text "R" ]
    ]
