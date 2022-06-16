module Http.Audius.Get exposing (get)

import Http
import Http.Audius.Response as Audius
import Json.Decode as Decode
import Msg.Msg exposing (Msg(..))

url : String
url =
    "https://discoveryprovider.audius.co/v1/tracks/trending"


responseDecoder : Decode.Decoder Audius.Response
responseDecoder =
    Decode.map Audius.Response
        (Decode.field "data" (Decode.list trackDecoder))


trackDecoder : Decode.Decoder Audius.Track
trackDecoder =
    Decode.map Audius.Track
        (Decode.field "title" Decode.string)

get : Cmd Msg
get =
    Http.get
        { url = url
        , expect = Http.expectJson AudiusGetResponse responseDecoder
        }

