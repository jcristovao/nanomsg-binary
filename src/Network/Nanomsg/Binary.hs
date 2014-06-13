{-| Simple binary serialization layer over Nanomsg.
 - It reexports most of Nanomsg api, except for the modified functions
-}

module Network.Nanomsg.Binary
  (
  -- * Types
  -- ** Socket types
    Pair(..)
  , Req(..)
  , Rep(..)
  , Pub(..)
  , Sub(..)
  , Surveyor(..)
  , Respondent(..)
  , Push(..)
  , Pull(..)
  , Bus(..)
  -- ** Other
  , Socket
  , Endpoint
  , NNException(..)
--  , eTERM
--  , eFSM
  , SocketType
  , Sender
  , Receiver
  -- * Operations
  -- ** General operations
  , socket
  , withSocket
  , bind
  , connect
  , send
  , recv
  , recv'
  , subscribe
  , unsubscribe
  , shutdown
  , close
  , term
  -- ** Socket option settings
  , linger
  , setLinger
  , sndBuf
  , setSndBuf
  , rcvBuf
  , setRcvBuf
  , reconnectInterval
  , setReconnectInterval
  , reconnectIntervalMax
  , setReconnectIntervalMax
  , sndPrio
  , setSndPrio
  , ipv4Only
  , setIpv4Only
  , requestResendInterval
  , setRequestResendInterval
  , surveyorDeadline
  , setSurveyorDeadline
  , tcpNoDelay
  , setTcpNoDelay

  ) where

import Control.Applicative
import Nanomsg hiding (send,send',recv,recv')
import qualified Nanomsg as NM
import Data.Binary
import Data.ByteString.Lazy

send
  :: (Sender s, Binary dat)
  => Socket s
  -> dat
  -> IO ()
send s d = NM.send s (toStrict . encode $ d)

recv
  :: (Receiver s, Binary dat)
  => Socket s
  -> IO dat
recv s = decode . fromStrict <$> NM.recv s

recv'
  :: (Receiver s, Binary dat)
  => Socket s
  -> IO (Maybe dat)
recv' s = fmap (decode . fromStrict) <$> NM.recv' s

