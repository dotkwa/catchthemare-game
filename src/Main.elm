module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class,src)
import Html exposing (br,img)
import Dict exposing (Dict)
import Random
import Random.List
import Set
import Set exposing (Set)
import Random.Extra exposing (result)
import Data exposing (..)

-- game params
initiallyBlockedFields : Int
initiallyBlockedFields = 10
boardSizeX : Int
boardSizeX = 11
boardSizeY : Int
boardSizeY = 11


type alias MareInfo =
  {
    name : List String,
    pieceImgData : String,
    msgBoxWinImgData : List String,
    rewardMsgTexts : List String
  }


lyra =
    { name = ["Lyra Heartstrings"],
      pieceImgData = Data.avatarlyra,
      msgBoxWinImgData = [Data.lyrahappy,Data.lyradress,Data.lyraflower],
      rewardMsgTexts = [
        "She spends the next 8 hours talking to you about oats.",
        "She shows you her expensive imported oat collection.",
        "After you let her go, your wallet is missing.",
        "She dances a modern dance with you! You feel great!",
        "She thoroughly snoofs your face from side to side. It tickles.",
        "As you hug her, she probes your face with her weird horsey lips."
      ]
    }
mares =
  [
    lyra,
    { name = ["Amethyst Star"],
      pieceImgData = Data.avataramethyst,
      msgBoxWinImgData = [Data.amethystsexy, Data.amethystcute],
      rewardMsgTexts = [
        "She rants about bread for 2 hours.",
        "She yells at the bread in your pocket.",
        "She takes you on a wonderful picnic in a nice sunny spot!",
        "She snuggles you tightly! Her coat is well groomed and very soft.",
        "She explains her elaborate organizing techniques while you share a sandwich."
      ]
    },
    { name = ["Minuette", "Colgate"],
      pieceImgData = Data.avatarminuette,
      msgBoxWinImgData = [Data.minuettehappy, Data.minuettecute],
      rewardMsgTexts = [
        "She hops a circle around you. She asks you questions faster than you can answer!",
        "She bounces into you and embraces you in a big hug. Ouch, her horn!",
        "She gives you valuable advice on how to keep your teeth clean.",
        "She brought a set of dental hygiene utensils for you. What are you waiting for? Get to work!",
        "You break into an energetic dance together. Shake those butts!",
        "She stares at you."
      ]
    },
    { name = ["Vinyl Scratch"],
      pieceImgData = Data.avatarvinyl,
      msgBoxWinImgData = [Data.vinyllewd, Data.vinylmusic],
      rewardMsgTexts = [
        "She puts her headphones over your ears and blasts her latest track.",
        "You spend the rest of the day talking about experimental electroacoustics.",
        "She brushes against you, making your hair stand on end with static electricity.",
        "She lets you put on her shades. The world has never looked this vibrant before.",
        "You stare deep into her mysterious eyes. What does this mare have to say to the world?"
      ]
    },
    { name = ["Berry Punch"],
      pieceImgData = Data.avatarberrypunch,
      msgBoxWinImgData = [Data.berryhappy, Data.berrypunchdrink],
      rewardMsgTexts = [
        "She lets you pet her mane. It's so smooth and soft!",
        "She breaks out a bottle of berry juice. It tastes delicious!",
        "Her head still hurts from yesterday. You give her a kiss on the brow to make it better.",
        "You throw out your plans for the day and follow her to the local vineyard.",
        "She loudly sings a raunchy song for you!",
        "You settle down together and have a nice nap. You both needed it!"
      ]
    },
    { name = ["Cherry Berry"],
      pieceImgData = Data.avatarcherryberry,
      msgBoxWinImgData = [Data.cherryberrysmile, Data.cherryberrywwu],
      rewardMsgTexts = [
        "Come on! She wants you to smile smile smile!",
        "She puts on her bee costume and offers you some honey.",
        "You sit down in a quiet embrace. She smells like cherries.",
        "She takes you to her balloon and gives you a pair of aviator goggles. Let's go!",
        "You sit down in the shade and she tells you all about her regular day in Ponyville."
      ]
    },
    { name = ["Bon Bon"],
      pieceImgData = Data.avatarbonbon,
      msgBoxWinImgData = [Data.bonbonhug, Data.bonboniwtci],
      rewardMsgTexts = [
        "Making sure nopony else is around, she shares in the latest gossip with you.",
        "She blinks her eyes in confusion.",
        "She gives you a friendly hug to make your day just a bit better.",
        "She gifts you some delicious candies.",
        "She shows you the apples in her bag, which she swears she didn't put in there.",
        "As you hold her, she snuggles into your chest and relaxes."
      ]
    },
    { name = ["Octavia", "Octavia Melody"],
      pieceImgData = Data.avataroctavia,
      msgBoxWinImgData = [Data.octavianice, Data.octavialewd],
      rewardMsgTexts = [
        "Blushing furiously, she permits you to hold her hoof.",
        "You have a pleasant conversation about the latest news in Canterlot high society.",
        "She plays you a song she created on her cello. She hopes you like it!",
        "You go with her for tea and biscuits.",
        "You sit together in silence. You both had a long day, the calm is very comfortable!"
      ]
    },
    { name = ["Rainbowshine"],
      pieceImgData = Data.avatarrainbowshine,
      msgBoxWinImgData = [Data.rainbowshinewwu, Data.sunbeam],
      rewardMsgTexts = [
        "You praise the sun together!",
        "You sit down and she tells you all about last Winter Wrap Up.",
        "She gifts you a pretty little cloud!",
        "You snuggle together for warmth. Her feathers are so delicate!",
        "You give her a big hug. She's beaming with happiness!"
      ]
    },
    { name = ["Spitfire", "Captain Spitfire"],
      pieceImgData = Data.avatarspitfire,
      msgBoxWinImgData = [Data.spitfiretowel, Data.spitfirewave],
      rewardMsgTexts = [
        "She gives you a fiery hug! You can't seem to free yourself from her embrace.",
        "She tells you all about the latest Wonderbolt drills.",
        "She slowly and sensuously offers you some apple pie.",
        "You sit down and have a beer together, laughing about raunchy jokes.",
        "She gives you a joking punch and flies away, leaving a burning trail. You can catch her tomorrow at the same time!"
      ]
    },
    { name = ["Sassaflash"],
      pieceImgData = Data.avatarsassaflash,
      msgBoxWinImgData = [Data.sassaflashhappy, Data.sassaflashtalking],
      rewardMsgTexts = [
        "She hugs you nice and long. She knows how much a simple hug can help your mood!",
        "She excitedly shows you the pineapple she found!",
        "She can't wait for next Nightmare Night and tells you all about her costume ideas!",
        "She tells you about her secret cloud hideout. If you want she can take you up there some day!",
        "She needs to get back to her weather duties and you have your work, but you take a short breather together!"
      ]
    },
    { name = ["Flitter"],
      pieceImgData = Data.avatarflitter,
      msgBoxWinImgData = [Data.flitterlewd, Data.flitterstretch],
      rewardMsgTexts = [
        "She takes you back home to meet Cloud Chaser.",
        "She flies some airy and elegant figures for you!",
        "You pick her up in a hug. She's so light!",
        "She opens her bow to adjust her mane, her pretty long hair falling over her face.",
        "She shows you how to properly do stretching exercises."
      ]
    },
    { name = ["Twilight Sparkle"],
      pieceImgData = Data.avatartwilight,
      msgBoxWinImgData = [Data.twilightcute, Data.twilightsleep],
      rewardMsgTexts = [
        "She goes off on the math problem she's currently trying to solve. She talks without break for an hour.",
        "She brought a new book. Do you want to browse it with her?",
        "She gives you a quick hug and asks you to come by the library for tea later.",
        "The girls are having another sleepover at the library. Do you want to join?",
        "She hugs you when you hear her belly rumble. You accompany her to get a snack."
      ]
    },
    { name = ["Rarity"],
      pieceImgData = Data.avatarrarity,
      msgBoxWinImgData = [Data.raritycute, Data.rarityface],
      rewardMsgTexts = [
        "You sit down and she tells you about her latest fashion line.",
        "She looks you over appraisingly. Do you want a new outfit tailored for you?",
        "She takes you into an elegant and ladylike embrace. Her perfume smells expensive.",
        "She's suddenly hit by an idea for a new dress. You have to follow her and be her aide for the rest of the day!"
      ]
    },
    { name = ["Applejack"],
      pieceImgData = Data.avatarapplejack,
      msgBoxWinImgData = [Data.ajcool, Data.ajdress],
      rewardMsgTexts = [
        "You sit in the shade and she tells you all about her last harvest.",
        "She puts her hat on your head before giving you a joyous hug.",
        "She brought some apples. You have a nice snack.",
        "It's not too long until the Running of the Leaves. Will you join this year?"
      ]
    },
    { name = ["Pinkie Pie"],
      pieceImgData = Data.avatarpinkie,
      msgBoxWinImgData = [Data.pinkiehug, Data.pinkiesocks],
      rewardMsgTexts = [
        "She slams into you and smothers you in a fierce hug.",
        "Before leaving, she reminds you of the exact number of hours until your birthday.",
        "She pulls out some sugary treats. You take a break to have a decadent snack.",
        "You sit down together as she tells you about everything she experienced today.",
        "She invites you home to show you her extensive sock collection."
      ]
    },
    { name = ["Rainbow Dash"],
      pieceImgData = Data.avatarrainbowdash,
      msgBoxWinImgData = [Data.rdcute, Data.rdshades, Data.rdbluedog],
      rewardMsgTexts = [
        "She asks why she keeps hearing you talk about a blue dog.",
        "She gives you a spectacular air show with rainbooms and barrel rolls.",
        "Making sure nopony's around to see you, she snuggles into your chest and lets you hug her.",
        "She gifts you her favourite pair of shades. They're sure to make you look 20% cooler.",
        "She's looking for a good spot to nap. Do you know one?",
        "She flies away, but not before circling back and giving you a fly-by kiss on your head."
      ]
    },
    { name = ["Fluttershy"],
      pieceImgData = Data.avatarfluttershy,
      msgBoxWinImgData = [Data.fluttershycute, Data.fluttershysexy],
      rewardMsgTexts = [
        "She meekly approaches you and takes you into a soft embrace.",
        "As you lie down with her, you notice her animal friends all around you, watching you.",
        "She lets you stroke her mane. It's so smooth and soft.",
        "She sings a pretty little song just for you.", 
        "You take a quiet and calm break together, away from the daily stresses."
      ]
    }
  ]


genericRewardMsgTexts =
  [
    "She leads you into a secluded place and coyly shows you her snowpity.",
    "She gives you a big warm hug to brighten your day!",
    "She gives you a tickly smooch on your cheek! It makes you laugh."
  ]



msgBoxLossContents =
  [
    Data.anonThatsKindOfSad,
    Data.junebugstare,
    Data.starecloudkicker,
    Data.stareblossomforth,
    Data.stareroseluck,
    Data.sweetiecry,
    Data.maresmad,
    Data.screm,
    Data.lyracry,
    Data.fsface
  ]

type FieldState =
  Empty
  | HasPiece
  | Blocked
getFieldState : Model -> (Int,Int) -> FieldState
getFieldState model idx =
  if model.piecePosition == idx then HasPiece
  else
    case model.board |> Dict.get idx of
    Just Empty -> Empty
    Just Blocked -> Blocked
    _ -> 
      Debug.log "can not happen"
      HasPiece
    
type alias Model =
  { 
    board : Dict (Int,Int) FieldState
    , piecePosition : (Int,Int)
    , lastPiecePosition : (Int,Int)
    , gameOnHold : Bool
    , msgBoxLine1 : String
    , msgBoxLine2 : String
    , msgBoxImageContent : String
    , pieceImageContent : String
    , msgBoxLossContent : String
    , msgBoxWinImageContent : String
    , mareName : String
    , msgBoxWinText : String
  } 

topLeftNeighbor : (Int,Int) -> Maybe (Int,Int)
topLeftNeighbor (x,y) =
  let
    nx = 
      if modBy 2 y == 0 then if x > 0 then Just (x - 1) else Nothing
      else Just x
    ny = if y > 0 then Just (y - 1) else Nothing
  in
    Maybe.andThen (\xx -> ny |> Maybe.map (\yy -> (xx,yy))) nx
   
topRightNeighbor : (Int,Int) -> Maybe (Int,Int)
topRightNeighbor (x,y) =
  let
    nx = 
      if modBy 2 y == 0 then Just x
      else if x < (boardSizeX - 1) then Just (x + 1) else Nothing
    ny = if y > 0 then Just (y - 1) else Nothing
  in
    Maybe.andThen (\xx -> ny |> Maybe.map (\yy -> (xx,yy))) nx

leftNeighbor : (Int,Int) -> Maybe (Int,Int)
leftNeighbor (x,y) =
  let
    nx = if x > 0 then Just (x - 1) else Nothing
    ny = Just y
  in
    Maybe.andThen (\xx -> ny |> Maybe.map (\yy -> (xx,yy))) nx
rightNeighbor : (Int,Int) -> Maybe (Int,Int)
rightNeighbor (x,y) =
  let
    nx = if x < (boardSizeX - 1) then Just (x + 1) else Nothing
    ny = Just y
  in
    Maybe.andThen (\xx -> ny |> Maybe.map (\yy -> (xx,yy))) nx

bottomLeftNeighbor : (Int,Int) -> Maybe (Int,Int)
bottomLeftNeighbor (x,y) =
  let
    nx = 
      if modBy 2 y == 0 then if x > 0 then Just (x - 1) else Nothing
      else Just x
    ny = if y < (boardSizeY - 1) then Just (y + 1) else Nothing
  in
    Maybe.andThen (\xx -> ny |> Maybe.map (\yy -> (xx,yy))) nx

bottomRightNeighbor : (Int,Int) -> Maybe (Int,Int)
bottomRightNeighbor (x,y) =
  let
    nx = 
      if modBy 2 y == 0 then Just x
      else if x < (boardSizeX - 1) then Just (x + 1) else Nothing
    ny = if y < (boardSizeY - 1) then Just (y + 1) else Nothing
  in
    Maybe.andThen (\xx -> ny |> Maybe.map (\yy -> (xx,yy))) nx

type StepResult =
  FreeField (Int,Int)
  | IntoBlock
  | Outside
tryStepRandom model =
  List.range 0 5 |> Random.List.shuffle |> Random.map (\idxs -> 
    List.foldl (\n idx -> 
      case idx of 
      IntoBlock -> 
        let 
          newPos = 
            case n of 
            0 -> topLeftNeighbor     model.piecePosition
            1 -> topRightNeighbor    model.piecePosition
            2 -> leftNeighbor        model.piecePosition
            3 -> rightNeighbor       model.piecePosition
            4 -> bottomLeftNeighbor  model.piecePosition
            5 -> bottomRightNeighbor model.piecePosition
            _ -> Nothing
        in 
          case newPos of 
          Nothing -> Outside
          Just iii -> 
            case getFieldState model iii of
            Empty -> FreeField iii
            _ -> IntoBlock
      _ -> idx
    ) IntoBlock idxs
  )

--breadth first search for path to outside
findPath : Model -> Set (Int,Int) -> List ((Int,List Int),(Int,Int)) -> List (Int,List Int)
findPath model visited toVisit =
  let
    neighs = 
      toVisit |> List.concatMap (\((count, pathToHere),here) -> 
        List.range 0 5 |> List.concatMap (\ n ->
          case n of 
          0 -> [((count, pathToHere), (here, 0,topLeftNeighbor     here))]
          1 -> [((count, pathToHere), (here, 1,topRightNeighbor    here))]
          2 -> [((count, pathToHere), (here, 2,leftNeighbor        here))]
          3 -> [((count, pathToHere), (here, 3,rightNeighbor       here))]
          4 -> [((count, pathToHere), (here, 4,bottomLeftNeighbor  here))]
          5 -> [((count, pathToHere), (here, 5,bottomRightNeighbor here))]
          _ -> []
        )
      )
    results =
      neighs |> List.concatMap (\((count, pathToHere), (here, num, neigh)) -> 
        case neigh of
        Nothing -> [(count+1,num::pathToHere)]
        Just neighbor -> []
      )
    newVisited =
      let 
        newEntries =
          neighs |> List.concatMap (\((count, pathToHere), (here, num, neigh)) -> 
            case neigh of
            Nothing -> []
            Just neighbor -> [neighbor]
          )
      in 
        List.foldl (\e v -> Set.insert e v) visited newEntries
    newToVisit =
      neighs |> List.concatMap (\((count, pathToHere), (here, num, neigh)) -> 
        case neigh of
        Nothing -> []
        Just neighbor ->
          if visited |> Set.member neighbor then []
          else
            case getFieldState model neighbor of
            Empty -> 
              [((count+1,num::pathToHere),neighbor)]
            _ -> []
      )
  in
    if (results |> List.length) > 0 || (newToVisit |> List.isEmpty) then 
      results
    else 
      findPath model newVisited newToVisit
  

tryMovePiece : Model -> (Model,Cmd Msg)
tryMovePiece model =
  let 
    randomStep = tryStepRandom model
    bfsStep = Random.constant (findPath model (Set.singleton model.piecePosition) [((0,[]),model.piecePosition)])
    combinedStep = 
      bfsStep |> Random.andThen (\path -> 
        if path |> List.isEmpty then 
          randomStep
        else 
          let 
            best =
              path 
              |> List.sortBy Tuple.first
              |> List.head
              |> Maybe.map Tuple.first
              |> Maybe.withDefault -1
            valid = 
              path 
              |> List.filter (\(len,_)->len==best)
            
            chosenStep =
              Random.List.choose valid
              |> Random.map (\(element,_) -> 
                let 
                  headNum =
                    element |> Maybe.andThen (\(length,chosenPath)->
                      chosenPath |> List.reverse |> List.head
                    )
                  in 
                    headNum |> Maybe.map (\num -> 
                      let 
                        a =
                          case num of
                          0 -> topLeftNeighbor     model.piecePosition
                          1 -> topRightNeighbor    model.piecePosition
                          2 -> leftNeighbor        model.piecePosition
                          3 -> rightNeighbor       model.piecePosition
                          4 -> bottomLeftNeighbor  model.piecePosition
                          5 -> bottomRightNeighbor model.piecePosition
                          _ -> Nothing
                      in 
                        case a of 
                        Nothing -> Outside
                        Just f -> FreeField f
                    ) |> Maybe.withDefault Outside --statically ensured
              )
          in
            chosenStep
      )
  in 
    (model,Random.generate PieceTriedStep combinedStep)

centerX : Int
centerX = boardSizeX//2
centerY : Int
centerY = boardSizeY//2
centerPosition : (Int,Int)
centerPosition = (centerX,centerY)

randomCoordExceptCenter : Random.Generator (Int,Int)
randomCoordExceptCenter =
  let 
    randomX = Random.andThen (\p -> if p<0.5 then Random.int 0 (centerX - 1) else Random.int (centerX + 1) (boardSizeX - 1)) (Random.float 0 1)
    randomY = Random.andThen (\p -> if p<0.5 then Random.int 0 (centerY - 1) else Random.int (centerY + 1) (boardSizeY - 1)) (Random.float 0 1)
  in
    Random.pair randomX randomY

emptyBoard : Dict (Int,Int) FieldState
emptyBoard = 
  List.range 0 (boardSizeX - 1)
  |> List.concatMap (\x-> 
    List.range 0 (boardSizeY - 1)
    |> List.map (\y-> 
      ((x,y),Empty)
    )
  ) |> Dict.fromList
 
startModel : Model
startModel = 
  {
    board=emptyBoard,
    piecePosition=centerPosition,
    lastPiecePosition=centerPosition,
    gameOnHold=False,
    msgBoxLine1 ="Line1",
    msgBoxLine2 ="Line2",
    msgBoxImageContent = "",
    pieceImageContent = Data.avatarlyra,
    msgBoxLossContent = Data.anonThatsKindOfSad,
    msgBoxWinImageContent = Data.lyrahappy,
    mareName = "",
    msgBoxWinText = ""
  }

initialModel : () -> (Model, Cmd Msg)
initialModel _ = 
    update ResetBoard startModel
main =
  Browser.element 
      { init = initialModel
      , subscriptions = \_->Sub.none
      , update = update
      , view = view
      }


shouldFaceRight model =
  let 
    lx = model.lastPiecePosition |> Tuple.first
    ly = model.lastPiecePosition |> Tuple.second
    x = model.piecePosition |> Tuple.first
  in
    if modBy 2 ly == 0 then 
      x >= lx
    else 
      x > lx
type Msg = 
  BlockField (Int,Int)
  | Clicked (Int,Int)
  | ResetBoard
  | BlockManyFields (List (Int,Int))
  | StepPiece
  | PieceTriedStep StepResult
  | SetGameOnHold Bool
  | SetMsgBoxText (String,String)
  | SetMsgBoxImageContent String
  | SetMsgBoxLossContent String
  | SetMsgBoxWinContent String
  | SetPieceImageContent String
  | SetMareName String
  | SetMessageBoxWinText String
  | SetMareCombined ((String,String),(String,String))

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    BlockField idx ->
      ({model | board=model.board |> Dict.insert idx Blocked},Cmd.none)
    Clicked idx -> 
      case getFieldState model idx of 
        Empty -> 
          let 
            (m1,c1) = update (BlockField idx) model
            (m2,c2) = update StepPiece m1
          in 
            (m2,Cmd.batch [c1,c2]) 
        _ -> (model, Cmd.none)
    ResetBoard -> 
      let 
        blockRandomFieldsCmd = Random.generate BlockManyFields (Random.list initiallyBlockedFields randomCoordExceptCenter)
        choseLossImgCmd = Random.generate SetMsgBoxLossContent (Random.List.choose msgBoxLossContents |> Random.map (\(m,_) -> m |> Maybe.withDefault Data.anonThatsKindOfSad))
        chooseMare = 
          Random.List.choose mares |> Random.andThen (\(m,_) -> 
            let 
              mm = m |> Maybe.withDefault lyra
              msgsRnd = 
                Random.List.choose (List.concat [mm.rewardMsgTexts,genericRewardMsgTexts])
                |> Random.map (\(e,_) -> e |> Maybe.withDefault "")
            in 
              msgsRnd |> Random.andThen (\winMsg->
                Random.List.choose mm.name |> Random.andThen (\(marename,_) -> 
                  Random.List.choose mm.msgBoxWinImgData |> Random.map (\(marewinimgdata,_) -> 
                    ((marename |> Maybe.withDefault "",mm.pieceImgData),(marewinimgdata |> Maybe.withDefault "",winMsg))
                  )
                )
              )
          )
        chooseMareCombined =
          Random.generate SetMareCombined chooseMare
      in
        (startModel, Cmd.batch [blockRandomFieldsCmd, choseLossImgCmd, chooseMareCombined])
    BlockManyFields idxs ->
      List.foldl (\idx (m,_) -> update (BlockField idx) m) (model,Cmd.none) idxs
    StepPiece -> 
      tryMovePiece model
    PieceTriedStep step -> 
      case step of 
      Outside ->  --loss condition
        let
            (m1,c1) = update (SetGameOnHold True) model
            (m2,c2) = update (SetMsgBoxText ("Oh no!","The mare got away.")) m1
            (m3,c3) = update (SetMsgBoxImageContent model.msgBoxLossContent) m2
        in
        (m3, Cmd.batch [c1,c2,c3])
      IntoBlock -> --victory condition
        let
            (m1,c1) = update (SetGameOnHold True) model
            (m2,c2) = update (SetMsgBoxText (String.concat ["Success! You caught ",model.mareName,"!"],model.msgBoxWinText)) m1
            (m3,c3) = update (SetMsgBoxImageContent model.msgBoxWinImageContent) m2
        in
        (m3, Cmd.batch [c1,c2,c3])
      FreeField newIdx -> 
        ({model | lastPiecePosition=model.piecePosition, piecePosition=newIdx},Cmd.none)
    SetGameOnHold hold -> 
      ({model | gameOnHold=hold},Cmd.none)
    SetMsgBoxText (l1,l2) ->
      ({model | msgBoxLine1=l1, msgBoxLine2=l2},Cmd.none)
    SetMsgBoxImageContent c -> 
      ({model | msgBoxImageContent=c},Cmd.none)
    SetPieceImageContent c -> 
      ({model | pieceImageContent=c},Cmd.none)
    SetMsgBoxLossContent c -> 
      ({model | msgBoxLossContent=c},Cmd.none)
    SetMareName c -> 
      ({model | mareName=c},Cmd.none)
    SetMsgBoxWinContent c -> 
      ({model | msgBoxWinImageContent=c},Cmd.none)
    SetMessageBoxWinText c -> 
      ({model | msgBoxWinText=c},Cmd.none)
    SetMareCombined ((mare,piece),(winImg,winText)) ->
      let
        (m1,c1) = update (SetMareName mare) model
        (m2,c2) = update (SetPieceImageContent piece) m1
        (m3,c3) = update (SetMsgBoxWinContent winImg) m2
        (m4,c4) = update (SetMessageBoxWinText winText) m3
      in
        (m4, Cmd.batch [c1,c2,c3,c4]) -- how the fuck to compose many updates

dialogbox : Model -> Html Msg
dialogbox model =
  let 
    classlist =
      String.concat [
        "dialogbox",
        if model.gameOnHold then "" else " hidden"
      ]
  in 
    div [class classlist] [
      img [class "msgboximg", src model.msgBoxImageContent] [],
      br [] [],
      div [class "text"] [text model.msgBoxLine1],
      div [class "text"] [text model.msgBoxLine2]
    ]

board : Model -> Html Msg
board model = 
  let
    classlist = 
      String.concat [
        "container",
        if model.gameOnHold then " disabled" else ""
      ]
  in
    div [class classlist] (
      List.range 0 (boardSizeY - 1) |> List.map (\ y-> 
        div [(if modBy 2 y == 0 then class "row-even" else class "row-odd")] (
          List.range 0 (boardSizeX - 1) |> List.map (\ x -> 
            let
                colorClass = 
                  case getFieldState model (x,y) of
                  Empty -> "field-empty"
                  HasPiece -> "field-piece"
                  Blocked -> "field-blocked"

                children =
                  case getFieldState model (x,y) of
                  HasPiece -> 
                    [
                      div [
                        if shouldFaceRight model then 
                          class "pieceimg pieceimg-faceright"
                        else  
                          class "pieceimg pieceimg-faceleft"
                      ] [
                        img [src model.pieceImageContent] []
                      ]
                    ]
                  _ -> 
                    [
                      --text (String.concat [String.fromInt x, ",", String.fromInt y])
                    ]

            in
            div [class (String.concat ["col ",colorClass])
              , onClick (Clicked(x,y))
              ] children
          )
        )
      )
  ) 

view : Model -> Html Msg
view model =
  div [] [ 
    button [onClick (ResetBoard), class "button"] [text "Reroll"]
    , br [] []
    , div [] [
      dialogbox model,
      board model
    ]
  ]
