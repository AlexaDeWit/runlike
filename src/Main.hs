module Main where

import           Linear.V2       (V2 (V2))

import           Helm
import           Helm.Sub
import           Helm.Color
import           Helm.Engine.SDL (SDLEngine)
import           Helm.Graphics2D
import           Types.GameMap
import           Maps.TestTown as TestTown

import qualified Helm.Cmd        as Cmd
import qualified Helm.Engine.SDL as SDL

data Action = Idle
data Model = Model (V2 Double) GameMap

initial :: (Model, Cmd SDLEngine Action)
initial = (Model (V2 0 0) TestTown.map, Cmd.none)

update :: Model -> Action -> (Model, Cmd SDLEngine Action)
update model Idle             = (model, Cmd.none)

subscriptions :: Sub SDLEngine Action
subscriptions = Helm.Sub.none

view :: Model -> Graphics SDLEngine
view (Model pos _) = Graphics2D $ collage [move pos $ filled (rgb 1 0 0) $ square 10]

main :: IO ()
main = do
  engine <- SDL.startup

  run engine GameConfig
    { initialFn       = initial
    , updateFn        = update
    , subscriptionsFn = subscriptions
    , viewFn          = view
    }
