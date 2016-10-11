import Optional as Opt exposing (Optional)

noService : Optional a -> Optional a -> Bool
noService shoes shirt =
  Opt.isNone shoes && Opt.isNone shirt


