module Main where

import           Helm
import           Helm.Sub
import           Helm.Color
import           Helm.Engine.SDL (SDLEngine)
import           Helm.Graphics2D
import           Model

import qualified Helm.Cmd        as Cmd
import qualified Helm.Engine.SDL as SDL

data Action = Idle


update :: Model -> Action -> (Model, Cmd SDLEngine Action)
update model Idle             = (model, Cmd.none)

subscriptions :: Sub SDLEngine Action
subscriptions = Helm.Sub.none

view :: Model -> Graphics SDLEngine
view (Model _) = Graphics2D $ collage [filled (rgb 1 0 0) $ square 10]

main :: IO ()
main = do
  engine <- SDL.startup

  run engine GameConfig
    { initialFn       = initial
    , updateFn        = update
    , subscriptionsFn = subscriptions
    , viewFn          = view
    }
