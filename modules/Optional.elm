module Optional exposing ( Optional(..), isNone )

type Optional a = Some a | None

isNone : Optional a -> Bool
isNone optional =
  case optional of
    Some _ ->
      False

    None ->
      True


