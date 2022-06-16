module View.LandingPage.LandingPage exposing (view)

import Html exposing (Html)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Msg.Msg exposing (Msg(..))
import View.Hero


view : Html Msg
view =
    View.Hero.view body


body : Html Msg
body =
    Html.div
        [ class "container"
        ]
        [ Html.div
            [ class "has-text-centered"
            ]
            [ Html.button
                [ onClick AudiusGet
                ]
                [ Html.text "fire off request"
                ]
            ]
        ]
