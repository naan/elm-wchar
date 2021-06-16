# elm-wchar

Determine columns needed for a fixed-size wide-character string.

----

elm-wchar is a simple Elm port of [wcwidth](http://man7.org/linux/man-pages/man3/wcswidth.3.html) implemented in C by Markus Kuhn
and [wcwidth](https://github.com/jquast/wcwidth) implemented in Python by Jeff Quast.

## Example

```elm
import WChar

String.length "한"   -- => 1
WChar.width '한'     -- => Wide (== 2)

String.length "한글"     -- => 2
WChar.stringWidth "한글" -- => 4
```

`WChar.width` and its string version, `WChar.stringWidth` are defined by IEEE Std
1002.1-2001, a.k.a. POSIX.1-2001, and return the number of columns used
to represent the given wide character and string.

Markus's implementation assumes the wide character given to those
functions to be encoded in ISO 10646, which is almost true for
JavaScript's characters.

## License

MIT
