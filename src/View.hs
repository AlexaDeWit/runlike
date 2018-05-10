module View where


import           Helm
import           Model
import           Helm.Color
import           Helm.Graphics2D

view :: Model -> Graphics engine
view (Model _) = Graphics2D $ collage [filled (rgb 1 0 0) $ square 10]

