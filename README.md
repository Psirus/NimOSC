NimOSC
======

![](https://github.com/Psirus/NimOSC/workflows/Tests/badge.svg)

A small wrapper around [liblo](https://github.com/radarsat1/liblo) for the Open Sound Control (OSC) protocol.

Very much *WIP*, but you can check the `example_client.nim` for, well, an example OSC client.

Of coures, you need to have `liblo` installed, under Debian/Ubuntu:

    sudo apt install liblo-dev

To run the tests, the `oscdump` tool is used. This is part of the `liblo-tools` package under Debian/Ubuntu.
