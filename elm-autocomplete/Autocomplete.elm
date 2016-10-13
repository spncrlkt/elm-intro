

-- MODEL


type State
  { key : Maybe String
  , mouse : Maybe String
  }


empty : State
empty =
  State Nothing Nothing

reset : State -> State
reset { key, mouse } =
  State Nothing mouse


-- UPDATE


type Msg
  = KeyChange String
  | WentTooLow
  | WentTooFar
  | MouseEnter String
  | MouseLeave String
  | MouseClick String


type alias UpdateConfig msg = 
  { onKeyDown : KeyCode -> Bool
  , onChoose : String -> msg
  , onTooLow : msg
  , onTooHigh : msg
  }


update : UpdateConfig msg -> Msg -> State -> (State, Maybe msg)
update config msg state =
  case msg of
    Change id ->
      ...

    WentTooLow ->
      (State Nothing state.mouse, wentTooLowMsg)


    WentTooFar ->
      (State Nothing state.mouse, wentTooFarMsg)



view : Config a -> Int -> State -> List a -> Hmtl Msg
view config howManyToShow state data  =
  ul
    [ onKeyDown
      -- compute 
    ] 
    [ li customAttributes customChildren
    ]

type alias Config a =
  { toId : a -> String
  , ul : List (Attributes Never)
  , li : Bool -> a -> HtmlDetails Never
  }


