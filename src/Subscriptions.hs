module Subscriptions where

import           Helm
import           Helm.Sub
import           Action

subscriptions :: Engine engine => Sub engine Action
subscriptions = Helm.Sub.none
