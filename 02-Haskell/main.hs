input = ["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"]

process1 :: [String] -> (Int, Int)
process1 a = processRecursive1 a

processRecursive1 :: [String] -> (Int, Int)
processRecursive1 [] = (0, 0)
processRecursive1 arr
    | command == "forward" = (((fst lastVal) + (read $ last text)), snd lastVal)
    | command == "down"    = (fst lastVal, (snd lastVal) + (read $ last text))
    | command == "up"      = (fst lastVal, (snd lastVal) - (read $ last text))
    where
        command = head text
        lastVal = processRecursive1 $ tail arr
        text = words $ head arr

process2 :: [String] -> (Int, Int)
process2 a = snd $ processRecursive2 $ reverse a

processRecursive2 :: [String] -> (Int, (Int, Int))
processRecursive2 [] = (0, (0, 0))
processRecursive2 arr
    | command == "forward" = (fst lastVal, (((fst lastCords) + (read $ last text)), ((snd lastCords) + ((fst lastVal) * (read $ last text)))))
    | command == "down"    = (((fst lastVal) + (read $ last text)), lastCords)
    | command == "up"      = (((fst lastVal) - (read $ last text)), lastCords)
    where
        command = head text
        lastVal = processRecursive2 $ tail arr
        lastCords = snd lastVal
        text = words $ head arr


multiplyTouple :: (Int, Int) -> Int
multiplyTouple (a, b) = a * b

main = do
    putStrLn . show . multiplyTouple $ process1 input
    putStrLn . show . multiplyTouple $ process2 input
