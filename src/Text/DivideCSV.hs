{-# LANGUAGE NoImplicitPrelude,OverloadedStrings,DoAndIfThenElse,RankNTypes #-}
module Text.DivideCSV where

--import Text.DivideCSV.Internal

import Prelude ((*),Int,Eq,IO,($),(>>),(.),return,const,succ,(++))
import System.IO (openFile,IOMode(..),hIsEOF,FilePath,hClose,print)
import Data.Either
import Text.Read
import Text.Show
import Data.Text
import Data.Text.IO
import Data.Conduit
import Control.Monad.IO.Class
import qualified Data.Conduit.List as CL

data DivConfig = DivConfig { divCFGFileName :: FilePath,
                             divCFGPages :: Int ,
                             divCFGLines :: Int ,
                             divCFGHeader :: Either Int Text ,
                             divFileSuffix :: Int }
               deriving (Eq,Read,Show)


csvSource :: DivConfig -> ConduitM i Text IO () 
csvSource (DivConfig f _ _ _ _) = do 
  handle <- liftIO $ openFile f ReadMode 
  addCleanup (const $ putStrLn "EOF" >> hClose handle) $ loop handle
 where
   loop handle = do 
     eof <- liftIO $ hIsEOF handle
     if eof 
     then return () 
     else do 
       t <- liftIO $ hGetLine handle
       yield t
       loop handle



divideFile :: DivConfig -> IO ()
divideFile cfg@(DivConfig f p l h s) = do 
  (csvSource cfg) $$ makeNewFile cfg --makeAllNewFiles cfg
  return ()

makeNewFile :: (Show b) => DivConfig -> Consumer b IO () 
makeNewFile cfg@(DivConfig f p l h s) = do 
   x <- toConsumer $  CL.isolate (p*l) =$ do 
                                          CL.mapM_ (\x-> appendFile (f ++ (show s)) x)
                                          CL.sinkNull
   liftIO $ print x
   case x of 
     () -> return () 
     _ -> makeNewFile cfg
   
         
--makeAllNewFiles :: (Show i) => DivConfig -> Conduit i IO ()
makeAllNewFiles cfg = do 
  CL.sequence (makeNewFile cfg) =$ CL.sinkNull
  
  


