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
init : (Model, Cmd Msg)
init =
    (Model Small "Example Content LMAO", Cmd.none)


-- MODEL
type alias Model =
  { fontSize : FontSize
  , content : String
  }

type FontSize
  = Small
  | Medium
  | Large


-- UPDATE
type Msg
  = ChangeFontSize FontSize

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangeFontSize fontSize ->
      (Model fontSize model.content, Cmd.none)


-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ contentView model.content model.fontSize
    , fieldset []
      [ radioView (ChangeFontSize Small) "Small"
      , radioView (ChangeFontSize Medium) "Medium"
      , radioView (ChangeFontSize Large) "Large"
      ]
    ]

contentView : String -> FontSize -> Html msg
contentView content currentFontSize =
  let
      fontPX =
        case currentFontSize of
          Small -> "10px"
          Medium -> "20px"
          Large -> "40px"
  in
    span [ style [("fontSize", fontPX)] ] [ text content ]



radioView : msg -> String -> Html msg
radioView msg title =
  label []
    [ input [type' "radio", name "font-size", onClick msg] []
    , text title
    ]

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
