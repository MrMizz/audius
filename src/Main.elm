module Main exposing (main)

-- MAIN

import Browser
import Browser.Navigation as Nav
import Html
import Http
import Http.Audius.Get as Get
import Model.Model as Model exposing (Model)
import Model.State as State exposing (State(..))
import Msg.Msg exposing (Msg(..), resetViewport)
import Sub.Sub as Sub
import Url
import View.About.About
import View.Error.Error
import View.LandingPage.LandingPage


main : Program () Model Msg
main =
    Browser.application
        { init = Model.init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.subs
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UrlChanged url ->
            ( { model
                | state = State.parse url
                , url = url
              }
            , resetViewport
            )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        AudiusGet ->
            ( model
            , Get.get
            )

        AudiusGetResponse result ->
            case result of
                Ok value ->
                    ( { model | state = Audius value }
                    , Cmd.none
                    )

                Err error ->
                    let
                        message =
                            case error of
                                Http.BadUrl string ->
                                    string

                                Http.Timeout ->
                                    "timeout"

                                Http.NetworkError ->
                                    "network error"

                                Http.BadStatus int ->
                                    String.fromInt int

                                Http.BadBody string ->
                                    string
                    in
                    ( { model | state = Error message }
                    , Cmd.none
                    )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        html =
            case model.state of
                LandingPage ->
                    View.LandingPage.LandingPage.view

                About ->
                    View.About.About.view

                Error error ->
                    View.Error.Error.view error

                Audius response ->
                    Html.div
                        []
                        (List.map
                            (\track -> Html.div [] [ Html.text track.title ])
                            response.data
                        )
    in
    { title = "Responsive Elm"
    , body =
        [ html
        ]
    }
