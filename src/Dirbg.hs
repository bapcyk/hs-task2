-- | dir.bg search support.
module Dirbg
    ( searchUrl
    , baseUrl
    , topLinks
    ) where


import Data.List as DL
import Text.Regex.TDFA
import Network.HTTP.Simple
import Control.Monad.Catch
import Control.Monad.IO.Class
import qualified Data.Text as DT
import qualified Data.Text.Encoding as DTE
import qualified Data.ByteString.Lazy.Char8 as LBS


-- | Base URL of the site
baseUrl =  "http://www.dir.bg/my/search.php?textfield="


-- | Creates search URL from `text` string. Actually it will be splitted
-- to words which will be searched
searchUrl :: String -> String
searchUrl text = baseUrl ++ (DL.concat $ DL.intersperse "+" $ words text)


-- | Makes HTTP GET request via URL `url` and returns top URLS
topLinks :: (MonadThrow m, MonadIO m) => String -> m [DT.Text]
topLinks url = do
  resp <- (parseRequest ("GET " ++ url) >>= httpLBS)
  let body = getResponseBody resp
      re = (   "class=.article.*[\n]*.*"
            ++ "class=.articletext.*[\n]*.*"
            ++ "class=.txt.*[\n]*.*"
            ++ "(<a href.*[\n]*.*</a>)")
      -- XXX default regex options includes multiline
      pies = (body =~ re :: [[LBS.ByteString]])
    in
    return $ map (DTE.decodeUtf8 . LBS.toStrict . (!!1)) pies
