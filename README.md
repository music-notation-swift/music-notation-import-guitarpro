![music-notation](https://user-images.githubusercontent.com/62043/111560932-cf4d1180-8750-11eb-842e-3159015c61ab.png)

[![Platform](https://img.shields.io/badge/Platforms-macOS%20-lightgrey.svg)](https://github.com/music-notation-swift/music-notation-import-guitarpro)
![Swift 6.0](https://img.shields.io/badge/Swift-5.4-F28D00.svg)
[![Build & Test](https://github.com/music-notation-swift/music-notation-import-guitarpro/actions/workflows/build-test.yml/badge.svg)](https://github.com/music-notation-swift/music-notation-import-guitarpro/actions/workflows/build-test.yml)
[![Lint](https://github.com/music-notation-swift/music-notation-import-guitarpro/actions/workflows/swiftlint.yml/badge.svg)](https://github.com/music-notation-swift/music-notation-import-guitarpro/actions/workflows/swiftlint.yml)
![Coverage Badge](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/woolie/b9f858cfba09911bd1755bdc40dd5a35/raw/music-notation-import-guitarpro__heads_main.json)

# music-notation-import-guitarpro

`music-notation` import code specific to Guitar Pro 8 files.

### Guitar Pro 8

Guitar Pro 8 is a zipped file format (`.gp`) which expands into a folder that has the following contents:

![Guitar Pro 8 File Format](images/gp7-contents.png)

The `score.gpif` file is an application specific XML file.

The source files in the GuitarPro7 folder are those specific to parsing this file format.

`music-notation-import-guitarpro` supports specifying the `gpif` file alone, or specifying the container `gp` file. Using the [ZIPFoundation](https://github.com/weichsel/ZIPFoundation) the process will pull out the `score.gpif` file and parse that directly.

####

There are two folders of code in the Guitar Pro 7 parser. One contains the parsing code (XML to Swift structured data), the other contains extension to the `music-notation` library that adds initializers that understand the parse data from the XML file.

## Notes

This is (obviously) a work in progress. It is meant to drive and help develop the `music-notation` project. It is one of the packages used by [music-notation-import](https://github.com/music-notation-swift/music-notation-import)
