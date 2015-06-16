# TKTokenField
An easily expandable drop-in replacement for NSTokenField that actually works

NSTokenField is not easy to subclass. I spent days fighting against it, to end up with an unreliable solution. Until I came with the need to do completion in an asynchronous way... And I didn't know where to start.

I tried a radically different approach by recoding it from scratch. It works significally better and ended up being much faster to implement.

TODOs
* Support pasteboard delegates
* Support cocoapods
* Tests
