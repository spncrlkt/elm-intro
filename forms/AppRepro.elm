import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

main =
  App.beginnerProgram
    { model = model
    , view = view
    , update = update
    }

--MODEL
type alias Model =
  { name : String
  , password: String
  , passwordAgain : String
  }

model : Model
model =
  Model "" "" ""

--UPDATE
type Msg
  = Name String
  | Password String
  | PasswordAgain String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password pw ->
      { model | password = pw }

    PasswordAgain pw ->
      { model | passwordAgain = pw }


--VIEW

view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", onInput Name ] []
    , input [ type' "password", placeholder "PW", onInput Password ] []
    , input [ type' "password", placeholder "PW Again", onInput PasswordAgain ] []
    , viewValidation model
    ]


viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if model.password == model.passwordAgain then
        ("green", "Y")
      else
        ("red", "N")
  in
    div [ style [("color", color)] ] [ text message ]

