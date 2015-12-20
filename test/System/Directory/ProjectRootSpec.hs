module System.Directory.ProjectRootSpec where

import           System.Directory.ProjectRoot
import           Test.Hspec

spec :: Spec
spec =
    describe "getProjectRoot :: FilePath -> IO (Maybe FilePath)" $
        it "doesn't seg fault" $ do
            mroot <- getProjectRoot "/"
            mroot `shouldBe` Nothing
