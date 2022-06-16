module Http.Audius.Response exposing (..)


type alias Response =
    { data : List Track
    }


type alias Track =
    { title : String
    }
