module Update where


import           Helm
import           Model
import           Action

import qualified Helm.Cmd        as Cmd

update :: Engine engine => Model -> Action -> (Model, Cmd engine Action)
update model Idle = (model, Cmd.none)
