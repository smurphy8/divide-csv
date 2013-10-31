{-# LANGUAGE NoImplicitPrelude,OverloadedStrings,DeriveDataTypeable #-}
module Main where
import ClassyPrelude
import Text.DivideCSV.Internal
import Text.DivideCSV

main :: IO () 
main = do
  (DivideCmds f p l h) <- runCmdArgs
  divideFile (DivConfig f p l (Left h) 0)
  print "done"



