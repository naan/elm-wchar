module WCharTest exposing (..)

import Expect
import Test exposing (test, Test)
import WChar exposing (width, stringWidth)


regular : Test
regular =
    test "handles regular strings"
        (\_ -> Expect.equal (stringWidth "abc") 3)


multibyte : Test
multibyte =
    test "handles multibyte character"
        (\_ -> Expect.equal (stringWidth "字的模块") 8)


mixed : Test
mixed =
    test "handles multibyte characters mixed with regular characters"
        (\_ -> Expect.equal (stringWidth "abc 字的模块") 12)


control : Test
control =
    test "ignores control characters e.g. \\n"
        (\_ -> Expect.equal (stringWidth "abc\n字的模块\ndef") -1)

emoji : Test
emoji =
    test "handle emojis"
        (\_ ->
            Expect.equal
                (stringWidth "abc🐶")
                5
        )


badInput : Test
badInput =
    test "ignores bad input"
        (\_ -> Expect.equal (stringWidth "") 0)


zeroWidth : Test
zeroWidth =
    test "zero width character"
        (\_ -> Expect.equal (width (Char.fromCode 10)) -1)


controlC0 : Test
controlC0 =
    test "control C0 with -1"
        (\_ -> Expect.equal (stringWidth "\u{001B}[0m") -1)


null : Test
null =
    test "ignores nul (charcode 0)"
        (\_ -> Expect.equal (width (Char.fromCode 0)) 0)


nullMixed : Test
nullMixed =
    test "ignores nul mixed with chars"
        (\_ ->
            Expect.equal
                (stringWidth ("a" ++ String.fromChar (Char.fromCode 0) ++ "\n字的"))
                -1
        )


zeroWidthChar : Test
zeroWidthChar =
    test "zero width characters"
        (\_ ->
            Expect.equal
                (stringWidth (String.fromChar (Char.fromCode 0x0300)))
                0
        )
