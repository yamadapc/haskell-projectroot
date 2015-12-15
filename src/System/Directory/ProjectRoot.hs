-- |
-- Module: System.Directory.ProjectRoot
-- Description: Find the root of a project
-- Copyright: (c) Pedro Tacla Yamada, 2015
-- License: MIT
-- Maintainer: tacla.yamada@gmail.com
-- Stability: Stable
-- Portability: POSIX
--
-- Simple way of finding the root of a project given an entry-point.
-- This module provides bindings to the <https://github.com/yamadapc/projectroot projectroot> C library
module System.Directory.ProjectRoot
  where

import           Control.Monad    ((<=<), (>=>))
import           Foreign.C
import           System.Directory (getCurrentDirectory)

-- * Haskell Wrappers

-- |
-- Find the project root given an entry point
getProjectRoot :: FilePath -> IO FilePath
getProjectRoot = (find_project_root <=< newCString) >=> peekCString

-- |
-- Find the weighted project root given an entry point
getProjectRootWeighted :: FilePath -> IO FilePath
getProjectRootWeighted = (find_project_root_weighted <=< newCString) >=>
                         peekCString

-- |
-- Find the project root of the current directory
getProjectRootCurrent :: IO FilePath
getProjectRootCurrent = getCurrentDirectory >>= getProjectRoot

-- |
-- Find the weighted project root of the current directory
getProjectRootWeightedCurrent :: IO FilePath
getProjectRootWeightedCurrent = getCurrentDirectory >>= getProjectRootWeighted

-- * C functions

foreign import ccall "find_project_root" find_project_root :: CString -> IO CString
foreign import ccall "find_project_root_weighted" find_project_root_weighted :: CString -> IO CString
