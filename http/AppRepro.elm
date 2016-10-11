import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Http
import Json.Decode as Json
import Task

-- MAIN
main = 
  App.program
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


-- INIT
init : (Model, Cmd Msg)
init =
    (Model "cat" "waiting.gif", Cmd.none)


-- MODEL
type alias Model =
  { topic : String
  , gifUrl : String
  }


-- UPDATE
type Msg
  = More
  | FetchSucceed String
  | FetchFail Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    More ->
      (model, getNewGifUrl model.topic)

    FetchSucceed newGifUrl ->
      (Model model.topic newGifUrl, Cmd.none)

    FetchFail _ ->
      (model, Cmd.none)

getNewGifUrl : String -> Cmd Msg
getNewGifUrl topic =
  let
    url =
      "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in 
    Task.perform FetchFail FetchSucceed (Http.get decodeGifUrl url)

decodeGifUrl : Json.Decoder String
decodeGifUrl =
  Json.at ["data", "image_url"] Json.string

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text model.topic ]
    , button [ onClick More ] [ text "MORE" ]
    , br [] []
    , img [ src model.gifUrl ] []
    ]

