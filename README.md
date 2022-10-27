# Friday Night Funkin -Lite Engine
![Discord](https://img.shields.io/badge/Discord-%237289DA.svg?style=for-the-badge&logo=discord&logoColor=white)(https://discord.gg/XZjzBBYAR)

## Credits / shoutouts
 FUNKIN CREW -
- [ninjamuffin99](https://twitter.com/ninja_muffin99) - Og Game Programmer
- [PhantomArcade3K](https://twitter.com/phantomarcade3k) and [Evilsk8r](https://twitter.com/evilsk8r) - Art
- [Kawaisprite](https://twitter.com/kawaisprite) - Musician
- [AngelDTF](https://github.com/AngelDTF) - Reverse engineering

TEAM 504 -
//CODERS
- [504brandon](https://github.com/504brandon)
- [InsKal](https://github.com/InsKal)
- [JustARock](https://www.youtube.com/watch?v=N2YRXOD8OSE)
- [MemeHoovy](https://github.com/MemeHoovy)
- [FutureDorito](https://www.youtube.com/watch?v=N2YRXOD8OSE)
- [Leather128](https://github.com/InsKal)
- [W0CKY](https://github.com/InsKal)
//ART
- [MEEPERS](https://www.youtube.com/watch?v=N2YRXOD8OSE)


## Compile tutorial !!!


Step 1. [Install Haxe](https://haxe.org/download/version/4.2.5/) 
2. [Install HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/) after downloading Haxe

Other installations you'd need is the additional libraries, a fully updated list will be in `Project.xml` in the project root. Currently, these are all of the things you need to install:
```
flixel
flixel-addons
flixel-ui
hscript
```
So for each of those type `haxelib install [library]` so shit like `haxelib install flixel`

You'll also need to install a couple things that involve Gits. To do this, you need to do a few things first.
1. Download [git-scm](https://git-scm.com/downloads). Works for Windows, Mac, and Linux, just select your build.
2. Follow instructions to install the application properly.
3. Run `haxelib git polymod https://github.com/larsiusprime/polymod.git` to install Polymod.
4. Run `haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc` to install Discord RPC.

At the moment, you can optionally fix some bugs regarding the engine:
1. A transition bug in songs with zoomed out cameras
- Run `haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons` in the terminal/command-prompt.
2. A text rendering bug (mainly noticeable in the story menu under tracks)
- Run `haxelib git openfl https://github.com/openfl/openfl` in the terminal/command-prompt.
3. If you want Texture Atlas chars, You should use FLXAnimate
  - Run `haxelib git flxanimate https://github.com/Dot-Stuff/flxanimate`

You should have everything ready for compiling the game! Follow the guide below to continue!

### Compiling game

Once you have all those installed, it's pretty easy to compile the game. You just need to run 'lime test html5 -debug' in the root of the project to build and run the HTML5 version. (command prompt navigation guide can be found here: [https://ninjamuffin99.newgrounds.com/news/post/1090480](https://ninjamuffin99.newgrounds.com/news/post/1090480))

To run it from your desktop (Windows, Mac, Linux) it can be a bit more involved. For Linux, you only need to open a terminal in the project directory and run 'lime test linux -debug' and then run the executable file in export/release/linux/bin. I'll add instructions for Mac once I get my hands on a macOS device. For Windows, you need to install [Visual Studio Build Tools](https://visualstudio.microsoft.com/downloads/?q=Build+Tools) (you'll need to scroll down a bit to find the download). While installing, don't click on any of the options to install workloads. Instead, go to the individual components tab and choose the following:
* MSVC C++ x64/x86 build tools (Tested with `MSVC v143 - VS 2022 C++ x64/x86 build tools (v14.33-17.3)`)
* Windows SDK (Tested with `Windows 10 SDK (10.0.19041.0)`)

This will install about 4GB of crap, but once that is done you can open up a command line in the project's directory and run `lime test windows -debug`. Once that command finishes (it takes forever, even on a higher end PC), you can run FNF from the .exe file under export\release\windows\bin
As for Mac, 'lime test mac -debug' should work, if not the internet surely has a guide on how to compile Haxe stuff for Mac.

### Additional guides

- [Command line basics](https://ninjamuffin99.newgrounds.com/news/post/1090480)
