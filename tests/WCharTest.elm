module WCharTest exposing (..)

import Expect
import Test exposing (Test, test)
import WChar

regular : Test
regular =
    test "handles regular strings"
        (\_ ->
            Expect.equal
                (WChar.stringWidth "abc")
                (Just 3)
        )


multibyte : Test
multibyte =
    test "handles multibyte character"
        (\_ ->
            Expect.equal
                (WChar.stringWidth "字的模块")
                (Just 8)
        )


mixed : Test
mixed =
    test "handles multibyte characters mixed with regular characters"
        (\_ ->
            Expect.equal
                (WChar.stringWidth "abc 字的模块")
                (Just 12)
        )


control : Test
control =
    test "ignores control characters e.g. \\n"
        (\_ ->
            Expect.equal
                (WChar.stringWidth "abc\n字的模块\ndef")
                Nothing
        )


emoji : Test
emoji =
    test "handle emojis"
        (\_ ->
            Expect.equal
                (WChar.stringWidth "abc🐶")
                (Just 5)
        )


badInput : Test
badInput =
    test "ignores bad input"
        (\_ ->
            Expect.equal
                (WChar.stringWidth "")
                (Just 0)
        )


zeroWidth : Test
zeroWidth =
    test "zero width character"
        (\_ ->
            Expect.equal
                (WChar.width (Char.fromCode 10))
                WChar.Control
        )


controlC0 : Test
controlC0 =
    test "control C0 with Nothing"
        (\_ ->
            Expect.equal
                (WChar.stringWidth "\u{001B}[0m")
                Nothing
        )


null : Test
null =
    test "ignores nul (charcode 0)"
        (\_ ->
            Expect.equal
                (WChar.width (Char.fromCode 0))
                WChar.Zero
        )


nullMixed : Test
nullMixed =
    test "ignores nul mixed with chars"
        (\_ ->
            Expect.equal
                (WChar.stringWidth ("a" ++ String.fromChar (Char.fromCode 0) ++ "\n字的"))
                Nothing
        )


zeroWidthChar : Test
zeroWidthChar =
    test "zero width characters"
        (\_ ->
            Expect.equal
                (WChar.stringWidth (String.fromChar (Char.fromCode 0x0300)))
                (Just 0)
        )
