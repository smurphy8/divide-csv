{-# LANGUAGE NoImplicitPrelude,OverloadedStrings,DeriveDataTypeable #-}
module Text.DivideCSV.Internal
    (DivideCmds(DivideCmds), runCmdArgs
    ) where
import System.Console.CmdArgs

import ClassyPrelude
import Data.String

data DivideCmds = DivideCmds { csvFilename :: String
                      ,pagesPer :: Int
                      ,linesPer :: Int 
                      ,headerLine :: Int }
        deriving (Show, Data, Typeable)


dflt = DivideCmds { csvFilename = "missing.csv",
                  pagesPer = 50   ,
                  linesPer = 50   ,
                  headerLine = 0 

                }
                  
                


runCmdArgs = cmdArgs dflt
  