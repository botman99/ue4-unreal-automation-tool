
## Table Of Contents

* [Unreal Automation Tool](#Unreal-Automation-Tool)  
&nbsp;&nbsp;&nbsp;&nbsp;[Getting Help](#Getting-Help)  
* [Building Code](#Building-Code)  
&nbsp;&nbsp;&nbsp;&nbsp;[Building The Editor](#Building-The-Editor)  
&nbsp;&nbsp;&nbsp;&nbsp;[Cleaning Before Building](#Cleaning-Before-Building)  
&nbsp;&nbsp;&nbsp;&nbsp;[Building Game Code](#Building-Game-Code)  
&nbsp;&nbsp;&nbsp;&nbsp;[Putting It All Together](#Putting-It-All-Together)  
&nbsp;&nbsp;&nbsp;&nbsp;[What To Do If The Build Fails](#What-To-Do-If-The-Build-Fails)  
* [Packaging Your Game](#Packaging-Your-Game)  
&nbsp;&nbsp;&nbsp;&nbsp;[What Happens When A Game Is Packaged](#What-Happens-When-A-Game-Is-Packaged)  
&nbsp;&nbsp;&nbsp;&nbsp;[Building Source Code](#Building-Source-Code)  
&nbsp;&nbsp;&nbsp;&nbsp;[Cooking Content](#Cooking-Content)  
&nbsp;&nbsp;&nbsp;&nbsp;[Staging Cooked Content](#Staging-Cooked-Content)  
&nbsp;&nbsp;&nbsp;&nbsp;[What Should You Cook?](#What-Should-You-Cook?)  
&nbsp;&nbsp;&nbsp;&nbsp;[Automating The Game Packaging](#Automating-The-Game-Packaging)  
&nbsp;&nbsp;&nbsp;&nbsp;[What To Do If The Packaging Fails](#What-To-Do-If-The-Packaging-Fails)  
&nbsp;&nbsp;&nbsp;&nbsp;[Patching And DLC](#Patching-And-DLC)  
* [Running The Batch Files Automatically](#Running-The-Batch-Files-Automatically)  
* [Advanced](#Advanced)  
&nbsp;&nbsp;&nbsp;&nbsp;[How to Debug Your AutomationTool Commands](#How-to-Debug-Your-AutomationTool-Commands)  

## Unreal Automation Tool

The Unreal Engine includes a tool called [Unreal AutomationTool](https://docs.unrealengine.com/en-US/ProductionPipelines/BuildTools/AutomationTool/index.html) or 'UAT' for short.  UAT is written in C# and is a collection of various tools that can be used to compile code, cook content and package your game (among other things).  In the engine, the AutomationTool source code can be found in the <tt>Engine/Source/Programs/AutomationTool</tt> folder (note that you will have the UAT source code even if you downloaded the Unreal Engine using the Epic Game Launcher and not from GitHub).

The overview of the Unreal AutomationTool can be found [here](https://docs.unrealengine.com/en-US/ProductionPipelines/BuildTools/AutomationTool/Overview/index.html).  The overview states the following:

"*AutomationTool is a host program and a set of utility libraries you can use to script unattended processes related to Unreal Engine when using C#. Internally, we use AutomationTool for a variety of tasks, including building, cooking, and running games, running automation tests, and scripting other operations to be executed on our build farm.*"

UAT is available for the Windows, Mac and Linux platforms (basically the same platforms that support the Unreal Editor).  Unreal AutomationTool needs to run in a Windows 'Command Prompt' window (or Terminal on Mac or Linux) since it is a commandline based tool and does not have a GUI interface.

To run UAT, there is a RunUAT.bat file (or RunUAT.command for Mac and <span>RunUAT.sh</span> for Linux) in the <tt>Engine/Build/BatchFiles</tt> folder.  When running UAT, you need to be in the Unreal Engine 'root' folder (the folder where you installed the engine) or in the <tt>Engine/Build/BatchFiles</tt> folder.  If you installed using the Epic Games Launcher, that will be something like <tt>C:\Program Files\Epic Games\UE_4.26</tt>.  You should see the "Engine" folder contained in the Unreal Engine 'root' folder.

For Windows, you can open up a Command Prompt window by clicking the Windows 'Start' button and typing "command prompt" (without the quotes).  When you open the command prompt window, you will be in your Windows 'user' directory by default.  If you installed the Unreal Engine in the default folder from the Epic Games Launcher, you can change to the Unreal Engine by using the 'cd' command.  Enter the following command in the command prompt window to change to that folder (including the double quotes);

    cd "\Program Files\Epic Games\UE_4.26"

Note: If you installed the Unreal Engine on the D: drive or some other drive, you will need to enter a command in the Command Prompt window to change to that drive first before you enter the command to change to the Unreal Engine installation folder:

    D:

Your Command Prompt window prompt should now look like this:

    C:\Program Files\Epic Games\UE_4.26>

Now you are ready to run UAT.  You run UAT by giving it a command followed by one or more commandline arguments.  The commandline arguments are preceded by a '-' character.  Let's start by running UAT without any command or arguments.  Enter the following and press the 'Enter' key (on Windows, make sure to use backslash '\\' characters and not forward slash '/' characters as you would on Mac or Linux):

    Engine\Build\BatchFiles\RunUAT.bat

...and here's what the output should look like:

    C:\Program Files\Epic Games\UE_4.26>Engine\Build\BatchFiles\RunUAT.bat
    Running AutomationTool...
    Parsing command line:
    ERROR: Failed to find scripts to execute in the command line params.
    AutomationTool exiting with ExitCode=1 (Error_Unknown)
    BUILD FAILED

The "ERROR: Failed to find scripts to execute" message means that we didn't give UAT a valid command to execute.

 So, let's run UAT again, but this time give it the "-List" commandline argument to have UAT display a list of all of the commands that it supports.  Enter the following command and press the 'Enter' key:

     Engine\Build\BatchFiles\RunUAT.bat -List

You will get a LONG list of commands (about a hundred or so) with each command on a separate line.  The commands aren't displayed in any particular order and aren't sorted alphabetically, so you may have to hunt around a little bit if you are looking for a specific command.

Here is the list that I get on my machine that I have sorted and broken into columns:

    AnalyzeThirdPartyLibs     CleanDevices                     RebasePublicIncludePaths     TestKillAll
    BenchmarkBuild            CleanFormalBuilds                RebuildHLOD                  TestLog
    BenchmarkOptions          CleanTempStorage                 RebuildLightMaps             TestMacZip
    BlameKeyword              CodeSurgery                      RecordPerformance            TestMcpConfigs
    Build                     CopySharedCookedBuild            ReplaceAssetsUsingManifest   TestMessage
    BuildCMakeLib             CopyUAT                          ResavePackages               TestOSSCommands
    BuildCommonTools          CryptoKeys                       ResavePluginDescriptors      TestP4_ClientOps
    BuildCookRun              DebugSleep                       ResaveProjectDescriptors     TestP4_CreateChangelist
    BuildDerivedDataCache     DumpBranch                       RunEditorTests               TestP4_Info
    BuildEditor               ExportIPAFromArchive             RunP4Reconcile               TestP4_LabelDescription
    BuildForUGS               ExportMcpTemplates               RunUnreal                    TestP4_StrandCheckout
    BuildGame                 ExtractPaks                      StashTarget                  TestRecursion
    BuildGraph                FinalizeInstalledBuild           SubmitUtilizationReportToEC  TestRecursionAuto
    BuildHlslcc               FixPerforceCase                  SyncBinariesFromUGS          TestStopProcess
    BuildPhysX                FixupRedirects                   SyncDDC                      TestSuccess
    BuildPlugin               GenerateAutomationProject        SyncDepotPath                TestTestFarm
    BuildServer               GenerateDSYM                     SyncProject                  TestThreadedCopyFiles
    BuildTarget               GitPullRequest                   SyncSource                   TestUATBuildProducts
    BuildThirdPartyLibs       IPhonePackager                   TempStorageTests             UBT
    CheckBalancedMacros       ListMobileDevices                TestArguments                UE4BuildUtilDummyBuildCommand
    CheckCsprojDotNetVersion  ListThirdPartySoftware           TestBlame                    UnstashTarget
    CheckForHacks             Localise                         TestChangeFileType           UpdateLocalVersion
    CheckPerforceCase         Localize                         TestChanges                  UploadDDCToAWS
    CheckRestrictedFolders    LookForOverlappingBuildProducts  TestCleanFormalBuilds        WriteIniValueToPlist
    CheckTargetExists         MegaXGE                          TestCombinePaths             ZipProjectUp
    CheckXcodeVersion         OpenEditor                       TestFail                     ZipUtils
    CleanAutomationReports    P4WriteConfig                    TestFileUtility
    CleanDDC                  ParseMsvcTimingInfo              TestGauntlet

### Getting Help

You can get help for a specific command by running UAT with the command followed by "-Help", for example:

    Engine\Build\BatchFiles\RunUAT.bat BuildGame -Help

Gives the following output:

    Running AutomationTool...
    Parsing command line: BuildGame -Help

    BuildGame Help:

    Builds the game for the specified project.
    Example BuildGame -project=QAGame -platform=PS4+XboxOne -configuration=Development.

    Parameters:
        -project=<QAGame>               Project to build. Will search current path and paths in ueprojectdirs.
        -platform=PS4+XboxOne           Platforms to build, join multiple platforms using +
        -configuration=Development+Test Configurations to build, join multiple configurations using +
        -notools                        Don't build any tools (UHT, ShaderCompiler, CrashReporter
    AutomationTool exiting with ExitCode=0 (Success)

The 'BuildGame' UAT command is used to compile your C++ game code.

Note that the AutomationTool will always exit with an 'ExitCode'.  For the above example, the ExitCode is 0 which is 'Success'.  This ExitCode can be used by other batch files or other applications that might run the AutomationTool to get a status result of whether the UAT command succeeded or failed.  This ExitCode is a result of whatever application the AutomationTool ran to handle the UAT command that you gave it.  For example, when using "RunUAT.bat BuildGame", UAT will run the UnrealBuildTool which is used to compile code.  It the code failed to be compiled successfully, UnrealBuildTool would return a non-zero exit code and UAT would also then return a non-zero exit code.  This can be used to determine whether your build failed or succeeded.

For reference, [here](https://docs.microsoft.com/en-us/windows/win32/debug/system-error-codes--0-499-) is a list of some Windows error codes (note that 0 is ERROR_SUCCESS).

If you are building the Unreal Engine from source code (downloaded from GitHub or from Epic's Perforce), you will see slightly different output for the BuildGame command...

    D:\GitHub\UnrealEngine>Engine\Build\BatchFiles\RunUAT.bat BuildGame -Help
    Running AutomationTool...
    Parsing command line: BuildGame -Help -compile
    Dependencies are up to date (0.226s). Skipping compile.

    BuildGame Help:

    Builds the game for the specified project.
    Example BuildGame -project=QAGame -platform=PS4+XboxOne -configuration=Development.

    Parameters:
        -project=<QAGame>               Project to build. Will search current path and paths in ueprojectdirs.
        -platform=PS4+XboxOne           Platforms to build, join multiple platforms using +
        -configuration=Development+Test Configurations to build, join multiple configurations using +
        -notools                        Don't build any tools (UHT, ShaderCompiler, CrashReporter
    AutomationTool exiting with ExitCode=0 (Success)

Notice that RunUAT.bat added "-compile" to the commandline arguments automatically and there's a line that says <tt>Dependencies are up to date (0.226s). Skipping compile.</tt>  When you are building the engine from source code, UAT will assume that the AutomationTool source code may have been modified by the user and will automatically rebuild itself each time it is run.  This allows you to make changes to the UAT source code or add your own AutomationTool commands to do custom automated tasks.  More on this is covered in the [Advanced](#Advanced) section below.

If you are using an Unreal Blueprint project for your game, you can skip down to the the [Packaging Your Game](#Packaging-Your-Game) section (since your project does not need to build C++ code).

## Building Code

If you have an Unreal Project that uses C++ or if you are building the engine from source code, you can automate the process of compiling the engine or your game code.  You do this using one of the 'Build' AutomationTool commands, such as: "BuildEditor", "BuildGame", "BuildServer", or "BuildTarget".

### Building The Editor

The 'BuildEditor' AutomationTool command is used to build the editor, but there are actually two different versions of "the editor".  There is the editor that gets built when you compile the UE4 project and then compile the editor for your game and there is a slightly different version of the editor that gets built if you only compile the editor for your game.  Building the editor for your game (like the "Development Editor" / "Win64" build configuration in Visual Studio) will only build the Engine modules and Plugin modules required by your game in an editor configuration.  Building the UE4 project in an editor configuration will build all Engine modules and all Plugin modules whether your game needs them or not.

What does this mean?  This means that if you build the editor only for your game, if Plugins are not enabled by default (and not required by other Engine modules), they won't get built.  This can saved you time when building.  This also means that you can't later enable a Plugin in the editor and then restart the editor without building again to compile the newly enabled but not yet built Plugin module(s).

Each module, whether an Engine module or Plugin module, when built for Windows, will create a DLL file named "UE4Editor-\<modulename\>.dll".  These files can be found in the <tt>Engine/Binaries/\<platform\></tt> folder or in the <tt>Engine/Plugins/.../Binaries/\<platform\></tt> folder.  There are a lot of these files.  You can get a list of them by changing to the Unreal Engine 'root' folder (where the 'Engine' folder is located) and running the following in the Windows Command Prompt window:

    dir /b/s | findstr Win64\\UE4Editor-.*\.dll

Replacing 'Win64' with 'Win32' if you are building the editor for 32-bit Windows.

For Unreal Engine version 4.26, when I build the UE4 project there are 395 Engine modules (in the <tt>Engine/Binaries/Win64</tt> folder) and 591 Plugin modules (under the <tt>Engine/Plugins</tt> folder).  If you create an "empty" C++ project (like when using the "First Person' or 'Third Person' template), clean the solution and then build the editor just for the game project, there are 352 Engine modules and only 181 Plugin modules.

Keeping that in mind, you can use "RunUAT.bat BuildEditor" without specifying a project to build the editor for the UE4 editor project and then use "RunUAT.bat BuildEditor -project=\<your_project_here\>" to build the editor for your game project to build everything, or you can just use "RunUAT.bat BuildEditor -project=\<your_project_here\>" to only build the modules required by your project.

### Cleaning Before Building

Sometimes you might want to force everything to be rebuilt from scratch.  In Visual Studio this is called "cleaning the solution".  This will delete any built executables (\*.exe or \*.dll files) and delete any intermediate files (like \*.obj or \*.lib files created by the compiler).  Why would you want to do this?  UnrealBuildTool (UBT) is used by Unreal to build code.  UBT does it's best to determine what needs to be rebuilt based on what has been recently modified and the dependency list it keeps of what depends on the things that were recently modified.  This usually works well, but there are situations where a header file is modified but UBT doesn't know that something needs to be rebuilt that might depend on that header file.  This usually happens when you have third-party libraries that you are using as part of your game code.  Unreal may detect that code needs to be rebuilt if the third-party library itself (\*.lib file) is modified, but may not build your game code if a header file in the third-party library was updated.

The Unreal AutomationTool doesn't have a command specifically for cleaning a project or the solution.  You can use "-clean" when you run "BuildEditor" or "BuildGame" (even though the help doesn't tell you this), and this will clean (delete) everything and then build.  But, if you use "BuildEditor -clean" to build the UE4 project editor and then use "BuildEditor -clean -project=\<your_project_here\>", it will clean (delete) all of the editor files you just built for the UE4 project and then build them again, which just wastes time.

As a side note, the reason that "BuildEditor -Help" doesn't tell you about "-clean" is that commands like "BuildEditor", "BuildGame", "BuildServer", etc. are all subclasses of the "BuildTarget" command.  You could use "BuildTarget" instead and specify additional commandline parameters to build the editor or game.  "BuildEditor -Help" only lists the commandline arguments that "BuildEditor" requires and not all the additional commandline arguments supported by the "BuildTarget" command.

The help for "BuildTarget" is the following:

    D:\GitHub\UnrealEngine>Engine\Build\BatchFiles\RunUAT.bat BuildTarget -Help
    Running AutomationTool...
    Parsing command line: BuildTarget -Help -compile
    Dependencies are up to date (0.196s). Skipping compile.

    BuildTarget Help:

    Builds the specified targets and configurations for the specified project.
    Example BuildTarget -project=QAGame
    -target=Editor+Game -platform=PS4+XboxOne -configuration=Development.
    Note: Editor will only ever build for the current
    platform in a Development config and required tools will be included

    Parameters:
        -project=<QAGame>               Project to build. Will search current path and paths in ueprojectdirs. If omitted
                                        will build vanilla UE4Editor
        -platform=PS4+XboxOne           Platforms to build, join multiple platforms using +
        -configuration=Development+Test Configurations to build, join multiple configurations using +
        -target=Editor+Game             Targets to build, join multiple targets using +
        -notools                        Don't build any tools (UnrealPak, Lightmass, ShaderCompiler, CrashReporter
        -clean                          Do a clean build
        -NoXGE                          Toggle to disable the distributed build process
        -DisableUnity                   Toggle to disable the unity build system
    AutomationTool exiting with ExitCode=0 (Success)

So, since there isn't an AutomationTool command specifically for cleaning a project or solution, we can use something else instead.  In the <tt>Engine/Build/Batchfiles</tt> folder, there is a "Clean.bat" batch file.  The Visual Studio solution uses this batch file to clean the UE4 project or the game project when cleaning the solution.  The commandline arguments for Clean.bat are not the same as for the RunUAT.bat batch file.

Clean.bat runs the UnrealBuildTool (UBT) executable.  This UnrealBuildTool.exe executable can be found in the <tt>Engine/Binaries/DotNET</tt> folder.  If you run UBT with the "-clean" commandline argument, it will clean the specified project.  You specify the desired project using the "-Target=" commandline argument, like so:

    Engine\Build\BatchFiles\Clean.bat -Target="UE4Editor Win64 Development" -WaitMutex -FromMSBuild

The "-Target=" argument specifies the project, in the format of, project name (like MyAwesomeGame) or editor (like MyAwesomeGameEditor), followed by the platform (Win32, Win64, Linux, Mac, etc.), followed by the build configuration (Development, Test, Shipping, etc).  The "-WaitMutex" is used by UBT to handle builds that use multiple processes to create a mutex that prevents several simultaneous processes from accessing the same file at the same time.  The "-FromMSBuild" is used to indicate that any error messages when compiling are coming from the [MSBuild](https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild?view=vs-2019) application (this is specific to Windows builds).

So the above "Clean.bat" command would clean the UE4 editor project.

When you clean or build your game, you need to use the "-Project=" argument to tell Unreal where your game project file is located.  This needs to be the full path to your .uproject file.  When passing the project file path as a commandline argument, you need to place it inside double quotes to preserve any spaces in the path.  The default path for projects would be under your Windows Documents folder in a folder called "Unreal Projects" followed by a folder name that matches your project name, for example:

    C:\Users\someuser\Documents\Unreal Projects\MyAwesomeGame

Windows has an environment variable called USERPROFILE for the "C:\User\someuser" part, so you could also use:

    %USERPROFILE%\Documents\Unreal Projects\MyAwesomeGame

The following would clean the MyAwesomeGame editor project:

    Engine\Build\BatchFiles\Clean.bat -Target="MyAwesomeGameEditor Win64 Development" -Project="%USERPROFILE%\Documents\Unreal Projects\MyAwesomeGame\MyAwesomeGame.uproject" -WaitMutex -FromMSBuild

...and the following would clean the MyAwesomeGame game code for the Development and Shipping build configurations:

    Engine\Build\BatchFiles\Clean.bat -Target="MyAwesomeGame Win64 Development" -Target="MyAwesomeGame Win64 Shipping" -Project="%USERPROFILE%\Documents\Unreal Projects\MyAwesomeGame\MyAwesomeGame.uproject" -WaitMutex -FromMSBuild

People who are running AutomationTool on Linux or Mac can replace the "Engine\Build\BatchFiles\Clean.bat" above with "Engine/Binaries/DotNET/UnrealBuildTool" instead to run the UBT application directly.

### Building Game Code

Now that you have built the editor, you are ready to build your game code.  This is the executable that will be used when you package your game to a format that will be released to the public (see [Packaging Your Game](#Packaging-Your-Game) below).

When you use "RunUAT.bat BuildGame", you build the executable for your game code.  This executable is used to load and run the "cooked" content that gets created when you package your game.  When you ship your game, you will usually build the 'Shipping' configuration of your game code.  The Shipping executable removes a bunch of output to the .log file (to make the game faster) and produces the most optimized compiled code, making your game code as fast as possible.  When you are testing your packaged build, you will want to use the 'Development' configuration.  The Development configuration keeps all of the output to the log file (to help with debugging problems) and has a lower level of optimization when compiling code (which makes it not as fast as possible).

Building the game code using RunUAT.bat is similar to building the editor, except we can specify multiple build configurations (Development and Shipping) to build both executables at the same time, like so:

    Engine\Build\BatchFiles\RunUAT.bat BuildGame -project="%USERPROFILE%\Documents\Unreal Projects\MyAwesomeGame\MyAwesomeGame.uproject" -platform=Win64 -configuration=Development+Shipping

When this is done, if you look in the <tt>Binaries/Win64</tt> folder of your project folder, you should see two executables (\*.exe file), one with the name of the project (MyAwesomeGame.exe) and one with 'Shipping' in it (MyAwesomeGame-Win64-Shipping.exe).  The executable with the 'Shipping' name in it is the one you want to include when releasing your game to players.

NOTE: If you are building the engine from source code, you can also build the game for the 'Debug' and 'Test' configurations.  The Debug configuration has all compiler optimizations disabled which makes it easier to debug your game code by running it in the debugger.  The 'Test' configuration has some of the log output disabled which makes it a little faster than the 'Development' configuration and has the same level of optimization as the 'Shipping' build, so the performance of the Test executable is closer to the performance of the Shipping executable (but with some logging enabled).  You could build all four configurations like so:

    Engine\Build\BatchFiles\RunUAT.bat BuildGame "%USERPROFILE%\Documents\Unreal Projects\MyAwesomeGame\MyAwesomeGame.uproject" -platform=Win64 -configuration=Debug+Development+Test+Shipping

### Putting It All Together

Now that we know how to clean and build the editor and game code, let's put it all together and create a batch file that does all this.  CleanAndBuild.bat (included in this github repository) is a batch file that will clean and build the editor as well as clean and build the game.  You can place this .bat file in the Unreal Engine 'root' folder (this will be something like <tt>C:\Program Files\Epic Games\UE_4.26</tt> if you installed from the Epic Launcher).  You will need to edit this .bat file with a text editor to change "MyAwesomeGame" to the name of your project.  Then you just need to open a Command Prompt window, change to the Unreal Engine 'root' folder and run "CleanAndBuild.bat" to automatically clean and build the project.

The CleanAndBuild.bat batch file will work for both the Installed version of Unreal Engine (installed from the Epic Games Launcher) and the source code version of Unreal Engine (downloaded from Epic's GitHub repository).  For the Installed version of the engine, CleanAndBuild.bat will only clean and build your project's editor and game code.  For the source code version of the engine, CleanAndBuild.bat will clean ALL executables from the <tt>Engine/Binaries/Win64</tt> folder (including tools), then fully rebuild the engine, tools, and your project's editor and game code.  If you have a Blueprint only project and are using the Installed version of the engine, the CleanAndBuild.bat file will do nothing (since there's nothing to build).  If you are building from engine source code and have a Blueprint project, the CleanAndBuild.bat file will still clean and build the engine and tools, but won't build anything for the game (since there's nothing to build there).

If you have problems building, you don't want to keep running CleanAndBuild.bat over and over again, because it will clean everything before building everything and that just slows things down.  Run CleanAndBuild.bat once, and if it fails, run the Build.bat batch file (included in this github repository) to just build everything.  Once something has been built successfully, it won't be built again and again.  UnrealBuildTool will skip over anything that is already up to date and allow you to just build whatever is failing over and over until you get the problem fixed.

### What To Do If The Build Fails

So, what do you do when the clean or build fails and you get errors?  The first thing you can do is run the CleanAndBuild.bat batch file and redirect the output to a text file like so:

    CleanAndBuild.bat > BuildLog.txt

This will redirect all the output that would have gone to the Command Prompt window and send it to the text file instead.  When the build is done (or fails), you can open the BuildLog.txt file in a text editor and examine the output more closely to help track down the cause of the failure.

UnrealHeaderTool and UnrealBuildTool also create log files when they run and you can look at these to help identify problems.  For Unreal Engine installed using the Epic Games Launcher, you will find log files under your Windows user's AppData folder.  To see the AppData folder in Windows Explorer, you need to show hidden folders.  One way to do this is to open Windows Explorer, click on 'View' from the menu and then click on 'Options', then click the 'View' tab and in the "Advanced settings:" section, under "Hidden files and folder", click the "Show hidden files, folders and drives" radio button and click the "OK" button to close the Options dialog.  You may need to close and re-open Windows Explorer to see the 'AppData' folder under your Windows user's folder (<tt>C:\\Users\\\<username\>\\AppData</tt>).

For Unreal Engine installed using the Epic Games Launcher, log files for UnrealHeaderTool can be found here:

    C:\Users\<username>\AppData\Local\UnrealHeaderTool\Saved\Logs

For Unreal Engine installed using the Epic Games Launcher, log files for UnrealBuildTool can be found here:

    C:\Users\<username>\AppData\Roaming\Unreal Engine\AutomationTool\Logs\C+Program+Files+Epic+Games+UE_4.26

...where "UE_4.26" will be replaced by the version number of the Unreal Engine that you are using.

If you are using a source code build of Unreal Engine (downloaded from GitHub), the log files for UnrealHeaderTool and UnrealBuildTool can be found in the <tt>Engine\Programs\AutomationTool\Saved\Logs</tt> folder in whatever directory you downloaded the GitHub source code into.

Log files that begin with "UHT-" are for UnrealHeaderTool and log files that begin with "UBT-" are for UnrealBuildTool.  Log files that are just "Log.txt" will be the output from the AutomationTool which will usually be whatever was being built when the build failed.

## Packaging Your Game

Whether you have a Blueprint project, or a C++ project, if you are going to ship your game for other people to play, you will need to [package your game](https://docs.unrealengine.com/en-US/Basics/Projects/Packaging/index.html).  There are many different ways to package your game from within the editor.  You can use the "Package Project" item from the "File" menu in the editor (as shown in the 'Packaging' docs.unrealengine.com link)  This will ask you where you want to place your packaged game and do everything automatically without asking for details.  You can also use "Window -> Project Launcher" in the editor, to open the ProjectLauncher dialog where you can create a custom Launch Profile that allows you to select maps you want to cook along with other options, then cook and stage the game and run the packaged game when it is done.  You can also get to the ProjectLauncher dialog by using the "Launch" dropdown in the main menu of the editor and select 'Project Launcher...', and finally, you can run the UnrealFrontend application and open the ProjectLauncher dialog from there.

All of the above methods of packaging your game use the AutomationTool command 'BuildCookRun' to compile your game code, cook content, and stage the cooked content as a packaged format.  Packaging your game is the most efficient method of distributing your game to other people for them to play.

So, let's look at the help output for the BuildCookRun command to see what it can do:

    Engine\Build\BatchFiles\RunUAT.bat BuildCookRun -Help

Here's what the output looks like:

    Running AutomationTool...
    Parsing command line: BuildcookRun -Help
    WARNING: Duplicated help parameter "-pak"
    WARNING: Duplicated help parameter "-package"
    WARNING: Duplicated help parameter "-deploy"
    WARNING: Duplicated help parameter "-iterativecooking"
    WARNING: Duplicated help parameter "-device"
    WARNING: Duplicated help parameter "-RunAutomationTests"
    WARNING: Duplicated help parameter "-NoXGE"

    BuildCookRun Help:

    Builds/Cooks/Runs a project.

    For non-uprojects project targets are discovered by compiling target rule files found in
    the project folder.
    If -map is not specified, the command looks for DefaultMap entry in the project's DefaultEngine.ini
    and if not found, in BaseEngine.ini.
    If no DefaultMap can be found, the command falls back to /Engine/Maps/Entry.

    Parameters:
        -project=Path                      Project path (required), i.e: -project=QAGame,
                                           -project=Samples\BlackJack\BlackJack.uproject,
                                           -project=D:\Projects\MyProject.uproject
        -destsample                        Destination Sample name
        -foreigndest                       Foreign Destination
        -targetplatform=PlatformName       target platform for building, cooking and deployment (also -Platform)
        -servertargetplatform=PlatformName target platform for building, cooking and deployment of the dedicated server
                                           (also -ServerPlatform)
        -foreign                           Generate a foreign uproject from blankproject and use that
        -foreigncode                       Generate a foreign code uproject from platformergame and use that
        -CrashReporter                     true if we should build crash reporter
        -cook,                             -cookonthefly Determines if the build is going to use cooked data
        -skipcook                          use a cooked build, but we assume the cooked data is up to date and where it
                                           belongs, implies -cook
        -skipcookonthefly                  in a cookonthefly build, used solely to pass information to the package step
        -clean                             wipe intermediate folders before building
        -unattended                        assumes no operator is present, always terminates without waiting for something.
        -pak                               generate a pak file
        -iostore                           generate I/O store container file(s)
        -signpak=keys                      sign the generated pak file with the specified key, i.e.
                                           -signpak=C:\Encryption.keys. Also implies -signedpak.
        -prepak                            attempt to avoid cooking and instead pull pak files from the network, implies pak
                                           and skipcook
        -signed                            the game should expect to use a signed pak file.
        -PakAlignForMemoryMapping          The game will be set up for memory mapping bulk data.
        -skippak                           use a pak file, but assume it is already built, implies pak
        -skipiostore                       override the -iostore commandline option to not run it
        -stage                             put this build in a stage directory
        -skipstage                         uses a stage directory, but assumes everything is already there, implies -stage
        -manifests                         generate streaming install manifests when cooking data
        -createchunkinstall                generate streaming install data from manifest when cooking data, requires -stage
                                           & -manifests
        -archive                           put this build in an archive directory
        -build                             True if build step should be executed
        -noxge                             True if XGE should NOT be used for building
        -CookPartialgc                     while cooking clean up packages as we are done with them rather then cleaning
                                           everything up when we run out of space
        -CookInEditor                      Did we cook in the editor instead of in UAT
        -IgnoreCookErrors                  Ignores cook errors and continues with packaging etc
        -nodebuginfo                       do not copy debug files to the stage
        -separatedebuginfo                 output debug info to a separate directory
        -MapFile                           generates a *.map file
        -nocleanstage                      skip cleaning the stage directory
        -run                               run the game after it is built (including server, if -server)
        -cookonthefly                      run the client with cooked data provided by cook on the fly server
        -Cookontheflystreaming             run the client in streaming cook on the fly mode (don't cache files locally
                                           instead force reget from server each file load)
        -fileserver                        run the client with cooked data provided by UnrealFileServer
        -dedicatedserver                   build, cook and run both a client and a server (also -server)
        -client                            build, cook and run a client and a server, uses client target configuration
        -noclient                          do not run the client, just run the server
        -logwindow                         create a log window for the client
        -package                           package the project for the target platform
        -skippackage                       Skips packaging the project for the target platform
        -distribution                      package for distribution the project
        -prereqs                           stage prerequisites along with the project
        -applocaldir                       location of prerequisites for applocal deployment
        -Prebuilt                          this is a prebuilt cooked and packaged build
        -AdditionalPackageOptions          extra options to pass to the platform's packager
        -deploy                            deploy the project for the target platform
        -getfile                           download file from target after successful run
        -IgnoreLightMapErrors              Whether Light Map errors should be treated as critical
        -stagingdirectory=Path             Directory to copy the builds to, i.e. -stagingdirectory=C:\Stage
        -ue4exe=ExecutableName             Name of the UE4 Editor executable, i.e. -ue4exe=UE4Editor.exe
        -archivedirectory=Path             Directory to archive the builds to, i.e. -archivedirectory=C:\Archive
        -archivemetadata                   Archive extra metadata files in addition to the build (e.g. build.properties)
        -createappbundle                   When archiving for Mac, set this to true to package it in a .app bundle instead
                                           of normal loose files
        -iterativecooking                  Uses the iterative cooking, command line: -iterativecooking or -iterate
        -CookMapsOnly                      Cook only maps this only affects usage of -cookall the flag
        -CookAll                           Cook all the things in the content directory for this project
        -SkipCookingEditorContent          Skips content under /Engine/Editor when cooking
        -FastCook                          Uses fast cook path if supported by target
        -cmdline                           command line to put into the stage in UE4CommandLine.txt
        -bundlename                        string to use as the bundle name when deploying to mobile device
        -map                               map to run the game with
        -AdditionalServerMapParams         Additional server map params, i.e ?param=value
        -device                            Devices to run the game on
        -serverdevice                      Device to run the server on
        -skipserver                        Skip starting the server
        -numclients=n                      Start extra clients, n should be 2 or more
        -addcmdline                        Additional command line arguments for the program
        -servercmdline                     Additional command line arguments for the program
        -clientcmdline                     Override command line arguments to pass to the client
        -nullrhi                           add -nullrhi to the client commandlines
        -fakeclient                        adds ?fake to the server URL
        -editortest                        rather than running a client, run the editor instead
        -RunAutomationTests                when running -editortest or a client, run all automation tests, not compatible
                                           with -server
        -Crash=index                       when running -editortest or a client, adds commands like debug crash, debug
                                           rendercrash, etc based on index
        -deviceuser                        Linux username for unattended key genereation
        -devicepass                        Linux password
        -RunTimeoutSeconds                 timeout to wait after we lunch the game
        -SpecifiedArchitecture             Determine a specific Minimum OS
        -UbtArgs                           extra options to pass to ubt
        -MapsToRebuildLightMaps            List of maps that need light maps rebuilding
        -MapsToRebuildHLODMaps             List of maps that need HLOD rebuilding
        -ForceMonolithic                   Toggle to combined the result into one executable
        -ForceDebugInfo                    Forces debug info even in development builds
        -ForceNonUnity                     Toggle to disable the unity build system
        -ForceUnity                        Toggle to force enable the unity build system
        -Licensee                          If set, this build is being compiled by a licensee
        -NoSign                            Skips signing of code/content files.
    AutomationTool exiting with ExitCode=0 (Success)

Wow!  There's a lot of stuff there.  Again, the arguments to the BuildCookRun command aren't sorted so it's a little difficult to find the specific argument you want and some arguments that can be used aren't show at all in the help.  The help also complains about "Duplicated help parameter" at the beginning because of the way the BuildCookRun command extends from other AutomationTool commands.

You don't need to understand what all of these arguments do, and some of them, like "-numclients" are obsolete and don't actually do anything.  The important ones you should know about are:

    "-clean"  This deletes intermediate files (like source code object files) and cleans (deletes) the previous cooked or staged (packaged) files before the packaging process starts.

    "-build"  If you have a C++ project, this will allow the packaging tool to build your source code to create the standalone executables used to load and run cooked content.

    "-cook"  This tells the AutomationTool to cook the game content for packaging.  Cooking removes data in the Unreal .uasset packages that is only needed in the editor, so cooking makes the assets a little smaller.  Cooking will also build shaders for any content that has shaders that are out of date.

    "-stage"  This tells the AutomationTool to stage the cooked content for packaging.  Staging the game also adds the game executable to the packaged format and can include the Epic Prerequisite installer (which installs DirectX and C runtime libraries if needed).

    "-platform="  This is the platform that you want to package for.  For Windows this would typically be "Win64" for 64-bit Windows operating systems.

    "-configuration="  This indicates which "build configuration" you want to use, which identifies which game executable will be included in the packaged build.  This can be "Development" to include the executable that has more log output and has the in-game console command window enabled.  It can be "Shipping" to include the shipping executable which has more optimized code and runs faster, but has no output and has the in-game console command window disabled (which makes debugging packaged game issues more difficult).  For people building from source code, you can also use the "Test" configuration which has less output than the "Development" configuration and makes it a little closer in performance to the "Shipping" configuration (but it still has the in-game console window enabled).  The "Test" configuration also has some 'stats' disabled so if you use any of the 'stat' commands in the console to help with profiling performance, you may be limited by some things not be available (like "stat fps" for example, but "stat unit" still works).

    "-pak"  This tells the packaging tool to put all of the cooked content into Unreal Engine .pak files, which can be compressed.  Pak files can also be encrypted to make it more difficult for people to tamper with your game or extract assets from your game.  Putting all your content into .pak files also makes it much harder to see which asets are getting packaged and which are not.  If you don't include the "-pak" argument, the packaged game will have asset files as "loose" files with the same folder structure as your game's Content folder, so temporarily disabling the .pak file format can help you identify when assets aren't getting cooked or staged.

### What Happens When A Game Is Packaged
So, now that we've gone over some of the BuildCookRun arguments, let's talk a little bit about what actually happens when you package your game.

#### Building Source Code

If you are building from source code, BuildCookRun can compile your project's game code and create the Development, Test, or Shipping executable.  These will be found under your project's Binaries folder in a folder with the platform name (for example, <tt>Binaries/Win64</tt> for the Windows 64 bit executables).  These executable files (\*.exe for Win64) will get copied to the staged folder by BuildCookRun.

#### Cooking Content

When cooking content, the cooked content will be placed in your project folder under the <tt>Saved/Cooked</tt> folder.  When packaging your game, you can package for several different types of game executables.  If you are not building from source code, you can only choose the "listen server" type of executable (which can run as a single player game, a listen server and a client).  This is referred to as a "no editor" build (because the cooked content can not be loaded into the editor).  For Windows, this packaging type is called "WindowsNoEditor", so when you cook, you will see a <tt>Saved/Cooked/WindowsNoEditor</tt> folder which will contain your project's cooked files.

If you are building from source code, in addition to the "no editor" type of package, you can cook for a dedicated server or for a dedicated client (that can only connect to a dedicated server).  Cooking for a dedicated server will only cook the content that the server needs (so you won't include things like audio assets which don't actually play on the server).  When cooking for a dedicated server for Windows, the cooked folder would be <tt>Saved/Cooked/WindowsServer</tt> and when cooking for a dedicated client, the cooked folder would be <tt>Saved/Cooked/WindowsClient</tt>.

#### Staging Cooked Content

After cooking, BuildCookRun will stage your game.  The staging process copies the cooked files into another folder and can (optionally) place all those cooked files into an Unreal Pak file (\*.pak) and the .pak file can be compressed to save disk space and download time.  For a Windows "no editor" build, the staged folder will be <tt>Saved/StagedBuilds/WindowsNoEditor</tt>.

After staging, in the "root" folder of the staged game (i.e. <tt>Saved/StagedBuilds/WindowsNoEditor</tt>), you will find one or more "Manifest" text files (\*.txt) that contains a list of files with a timestamp.  These Manifest text files are not needed to run the game and can be removed.

Also in the "root" folder you will find one or more executable files (\*.exe for Windows) that are "bootstrap" executables that will run your game executable file.  The bootstrap executables are just a convenient way of launching your game instead of having to point directly to the game executable (which would be located in <tt>Saved/StagedBuilds/WindowsNoEditor/Engine/Binaries/Win64</tt> for a Blueprint only project, or in <tt>Saved/StagedBuilds/WindowsNoEditor/\<project_name\>/Binaries/Win64</tt> for a C++ project).

The bootstrap executable will also automatically install the Unreal prerequisites (DirectX, C runtime libraries, etc.) if they have not already been installed.  This requires that you package your game with the option to include prerequisites.

By the way, if you are building from source code, you can find the code used to create the bootstrap executable in the <tt>Engine\Source\Programs\Windows\BootstrapPackagedGame</tt> folder, in case you want to customize it to run a custom app that can set game options like screen resolution, windowed or fullscreen mode, mouse sensitivity, or any user accessibility options, before launching the game.  The AutomationTool command "BuildCommonTools" can be used to build the bootstrap executable.

If you use "Package Project" from the "File" menu in the Unreal editor, it will ask you for the folder name where you want to place your packaged game.  This uses the "-archive" and "-archivedirectory=" arguments for BuildCookRun to copy the staged folder off to some other user specified folder.  The archive folder that you specify will contain the same folders and files as the <tt>Saved/StagedBuilds</tt> folder.  So for the Windows "no editor" build, you will find a "WindowsNoEditor" folder containing the same thing as the staged folder, including the unnecessary Manifest .txt file(s).  This may make it a little easier for you to store different versions of the packaged game in different folders in case you need to keep older versions of a packaged game for reference later.

#### What Should You Cook?

When using "Package Project" from the "File" menu in the Unreal editor, the editor will cook, stage and package **ALL CONTENT** in your game (whether it is used by the game or not).  This can wind up making your packaged game much bigger than necessary.  You can reduce what is cooked by using the "-map=" argument when running BuildCookRun.  You specify all the maps that are part of your game and the cooker will cook content (assets) that are referenced directly by the map.  It will also cook content that is referenced by other content that is to be cooked, and so on, and so on.  So maps will reference content and that content may reference other content and that content may reference other content, etc.  This will "spider out" until all content that is being referenced by the game has been determined and then everything will be cooked.

As an example, I created an "empty" Third Person Blueprint project including the Starter Content using the editor.  I then used "Package Project" from the "File" menu with no other changes and made note of the size of the cooked and staged folders.  With no maps specified, this is the size of the folders:

    Cooked folder:       568 MB, 1,228 Files
    Staged folder:       698 MB, 23 Files (.pak file size was 569 MB)
    PackageGame folder:  698 MB, 23 Files (.pak file size was 569 MB)

I then used UnrealFrontend to create a profile that only cooked the 'ThirdPersonExampleMap' and this was the size of the folders after cooking and staging:

    Cooked folder:        103 MB, 535 Files
    Staged folder:        236 MB, 23 Files (.pak file size was 107 MB)
    PackagedGame folder:  236 MB, 23 Files (.pak file size was 107 MB)

The game still runs the same.  You load into the 'ThirdPersonExampleMap' and it has the same content as when no maps were specified, but I eliminated all the Starter Content that was not actually used by the game.  This make the packaged game **about one third** the size of the "Package Project" defaults!!!

So, specifying specific maps to cook can make the packaged game smaller, but there is a "down side" to this.  If you are dynamically loading content at run-time (like loading custom skins for a character), if that content does not have a "hard" reference in a map or in your user interface, then that content will not get cooked (since it's not referenced by any other content).  To prevent this problem, there is an .ini setting you can use to add specific folders to a list to indicate that ALL the content in those folders (and sub-folders) should ALWAYS be cooked even if they aren't referenced by anything.

In the editor, these additional folders can be set in the Project Packaging Settings where it says "Additional Asset Directories to Cook".  From the editor main menu, just click "Edit", then "Project Settings", then under the 'Project' group on the left, click the "Packaging" item and scroll down until you see "Additional Asset Directories to Cook" and click the '+' sign to start adding folders.  Browse to the Content folder of your game project that you want to add to the list of folders containing content that should always be cooked.  After adding the first Content folder, click the little "down arrow" drop down at the end of the folder name and select "Insert" to add additional folders.  You can see these folders in the DefaultGame.ini file for your project in the <tt>\[/Script/UnrealEd.ProjectPackagingSettings\]</tt> section with the <tt>+DirectoriesToAlwaysCook=</tt> set to the folder name to cook.

#### Automating The Game Packaging

To automate the game packaging process, I have created a Windows batch file called 'PackageGame.bat' that needs to be placed in the Unreal Engine "root" folder (where you have Unreal Engine installed on your machine).  If you are using an installed build, installed from the Epic Games Launcher, the default location of the "root" folder will be the <tt>C:\\Program Files\\Epic Games\\UE_4.26</tt> folder (replace 4.26 with whatever version of the engine you are using).  If you are building from source code from GitHub, it will whatever folder you cloned the Unreal Engine repository to (you should see "Engine", "FeaturePacks", "Samples" and "Templates" folders in the UE4 "root" folder).  It is important that the batch file be placed in this "root" folder.  It won't work if it is run from somewhere else.

The easiest way to get the batch files for this guide is to download the .zip file of the latest release.  Go to the [Releases](https://github.com/botman99/ue4-unreal-automation-tool/releases) page, and click on the "Source code (zip)" link of the latest release to download the .zip file, then extract the PackageGame.bat file to your Unreal Engine "root" folder.

You will need to edit the PackageGame.bat file in a text editor to set it up for your project.  Near the top of the file, you will see this line:

    set PROJECT_NAME=MyAwesomeGame

You need to replace "MyAwesomeGame" with the name of your Unreal Engine project.  Save the file and exit from the text editor.  You can run the batch file by just double clicking on it in Windows Explorer.

If you want to indicate specific maps to cook, you can edit the PackageGame.bat file and look for the following line:

    set MAPS=

Here you want to specify a list of maps to cook and stage by providing the name of the map files separated by a '+' sign (**but don't use ANY SPACES**), like so:

    set MAPS=MainMenuMap+FirstLevel+SecondLevel+TestMap

If everything runs correctly, in your Unreal Project folder (under the <tt>C:\\Users\\\<username\>\\Documents\\Unreal Projects</tt> folder) you should find two new folders, "PackagedGame" and "Releases".  Inside the <tt>PackageGame</tt> folder will be the folder for your platform ("WindowsNoEditor").  Inside the platform folder will be your packaged game, ready to run.  You can doubleclick on the executable(s) in that folder to run the game.

Inside the <tt>Releases</tt> folder will be a folder name for the release version of this packaged build (in this case "1.0").  This is used if you want to release Patches or DLC for your game (more on this down below).

#### What To Do If The Packaging Fails

If the packaging process fails, the PackageGame.bat batch file will create a text file named <tt>PACKAGING_FAILED.txt</tt> in the "root" folder (where you placed the PackageGame.bat file).  So, if this "PACKAGING_FAILED.txt" file does not exist after running the PackageGame.bat file, then the packaging process was successful.

But what do you do if there are errors and the packaging process fails?  Unreal creates log files from the AutomationTool and other applications under your Windows user's AppData folder.  To see the AppData folder in Windows Explorer, you need to show hidden folders.  One way to do this is to open Windows Explorer, click on 'View' from the menu and then click on 'Options', then click the 'View' tab and in the "Advanced settings:" section, under "Hidden files and folder", click the "Show hidden files, folders and drives" radio button and click the "OK" button to close the Options dialog.  You may need to close and re-open Windows Explorer to see the 'AppData' folder under your Windows user's folder (<tt>C:\\Users\\\<username\>\\AppData</tt>).

Inside your user's AppData folder will be a <tt>Roaming</tt> folder.  And inside the "Roaming" folder will be an <tt>Unreal Engine</tt> folder.  Use Windows Explorer to browse down into the "Unreal Engine" folder here:

    C:\Users\<username>\AppData\Roaming\Unreal Engine

Inside the "Unreal Engine" folder will be a <tt>AutomationTool</tt> folder.  Browse down into that "AutomationTool" folder and you should see a <tt>Logs</tt> folder.  Browse down into the "Logs" folder and you should see a long folder name with the version number at the end (like <tt>C+Program+Files+Epic+Games+UE_4.26</tt>).  Browse into that folder and you should see some .txt files.  These are the log files from the cooking, staging, and packaging process.

The <tt>Log.txt</tt> file is the output from AutomationTool running all of the steps necessary to cook, stage and package your game.  The text file that starts with "Cook" is the output from the cooking process.  If the cooker fails, you can examine this file in a text editor and search for "Error:" (without the double quotes) to find any error messages.  If the staging process fails, the error messages will be in the Log.txt file (since this process is handled by AutomationTool itself).  You can search the Log.txt file for "Error:" (without the double quotes) to find any error messages.  If the process creating the .pak file fails, the text file that begins with "UnrealPak" will contain any error messages (again, search for "Error:" without the quotes).

Each time the AutomationTool runs, it will clean out (delete) any previous .txt files from the AutomationTool folder and will create new versions of these files as the packaging process progresses.  There will always be a "Log.txt" file (from the AutomationTool), but the other files won't exist unless that part packaging process either ran and failed, or ran and succeeded.

If you have trouble determining the cause of the error, you can still package the game in the Unreal Editor using the "Package Project" item from the "File" menu in the editor, or using the "Project Launcher" in the editor and this should present the error to you in a more "user friendly" way.

#### Patching And DLC

  See the [How To Create a Patch](https://docs.unrealengine.com/en-US/SharingAndReleasing/Patching/GeneralPatching/HowToCreatePatch/index.html) webpage for documentation on creating patches.  The PackageGame.bat file uses "1.0" as the first release version of your game (which is referenced in the "How To Create a Patch" webpage).  After packaging and releasing your game, you should zip up the Releases folder and keep the .zip file somewhere safe.  You can't go back later and make a new Releases folder to create a Patch if you forget to do it the first time with your initial release.  The data in the Releases folder won't match your initial release to the public and patching won't work properly.

The main difference between Patches and DLC is that Patches are modifications to the main game content along with (optionally) bug fixes to C++ code.  DLC is a game specific Plugin that contains additional content that can be added to the game at a later date after the game has been released.  For DLC, you will need to create a new Plugin (usually inside the game's Project folder) and create new content in that Plugin folder.

You use Project Launcher in the editor to create a profile to cook and package your patch or DLC and you check the "Generate Patch" or "Build DLC" checkbox in the "Release / DLC / Patching Settings" in the "Cook" section of your Project Launcher profile.  You also set the "Release version this is based on" to "1.0" to indicate that the cooker should use the metadata from your release build to cook and stage a patch or DLC package.

When the cooker cooks for a patch or DLC, it will compare the metadata for each cooked file for the released version of the game (the stuff in the Releases/1.0 folder) with the metadata of the game's current content.  If the metadata is different then the cooker knows that this content has been modified (or is new) and will ONLY cook that new or modified content.  This cooked data is then packaged as a new Patch or DLC package that can be downloaded separately from the game's original packaged build.  Each time you make a patch, a new patch package is created and these are "cumulative" meaning that you ONLY need the latest patch package to get all previous patch content changes.  The end user doesn't need to download every patch, they only need to download the latest patch to get everything (assuming that they have already downloaded the base released game).  Patches are typically much, much smaller than the original game package which saves the end user from having to download the entire game again to get updated content.

## Running The Batch Files Automatically

So, now that you have batch files that compile your code or package your game, how do you get these to run automatically?  To run the batch file(s) we will create a Windows Task that is scheduled to run at a specific time.  This will allow you to run an automated build during the night and have everything updated by the next morning.

To create a task in Windows, we will use the Task Scheduler application.  Here's the steps needed to set up an automated task:

1. Click the Windows 'Start' button, search for "Task Scheduler" and click on it.

2. Select the "Task Scheduler Library" folder, then right click on it and select "New Folder" and name the new folder "UnrealEngine".

3. Select the "UnrealEngine" folder in Task Scheduler, then right click on it and select "Create Basic Task...".

4. Give the new task a name like "Nightly Build" or "Nightly Package" and give it a description so that you know what this task is doing.

5. Select "Daily" as the Trigger type and click the 'Next' button.

6. Select the time when you want the task to run (like 4:00 am or something) and click the 'Next' button.

7. Select "Start a program" for the Action and click the 'Next' button.

8. Click the "Browse..." button for 'Program/script' and browse to the batch file that you want to run (for example 'CleanAndBuild.bat' or 'PackageGame.bat') in the Unreal Engine "root" folder, select the batch file and click the 'Open' button.

9. Where it says "Start in (optional)", copy/paste the path of the Unreal Engine "root" folder from the 'Program/script' line.  Make sure to remove the batch file name at the end and remove any double quotes from the path name.  You should have something like <tt>C:\Program Files\Epic Games\UE_4.26</tt> when using an installed build from the Epic Games Launcher.

10. Check the "Open the Properties dialog for this task when I click Finish" checkbox.

11. Then click the 'Finish' button and a new dialog box will pop up.

12. In the "Security options" section, select the "Run whether user is logged in or not" radio button and click the 'OK' button.

13. Enter the password for your Windows user account (so that Windows can log into your account if you are signed out when the task runs) and click the 'OK' button.

You should now see the task in the "UnrealEngine" folder of Task Manager with the information about when it runs, etc.  Look at the "Next Run Time" column to verify that the time you expect it to run is correct.  In the "Last Run Result" column, it should say "The task has not yet run".

The task should run at it's scheduled time and you should see files in your Unreal project were updated by the batch file.  If the task fails to run, open Task Scheduler, expand the "UnrealEngine" folder, select the task you created and look at the "Last Run Result" column to see if it indicates why the task did not run.  Check to make sure that you have the proper path in the "Start in (optional)" setting of the task (you can edit the task to change this if needed).

## Advanced

You can create your own AutomationTool commands to run custom tasks.  AutomationTool is written in C# so you will need to be familiar with the C# programming language to create custom automation commands.

First you need to add an Automation Project to your Game Project (this is similar to an Unreal game project but for the AutomationTool instead).  See this link for details on adding your own Automation Project:

https://docs.unrealengine.com/en-US/ProductionPipelines/BuildTools/AutomationTool/HowTo/AddingAutomationProjects/index.html

After creating the Automation Project, you can add custom commands to your Automation Project.  See the following link for details on how to do that:

https://docs.unrealengine.com/en-US/ProductionPipelines/BuildTools/AutomationTool/HowTo/AddingCommands/index.html

### How to Debug Your AutomationTool Commands

To run the AutomationTool code in the Visual Studio debugger, you need to set the AutomationTool as the startup project.  To do this, expand the "Programs" folder in the Visual Studio Solution Explorer and right click on 'AutomationTool' and select "Set as Startup Project".  This will launch the AutomationTool application when you start the debugger.  You will also need to set commandline arguments for AutomationTool when running it.  Right click on 'AutomationTool' again and select "Properties" then in the Properties dialog, click on 'Debug' and set "Command line arguments:" to the same command line arguments that you would use when running the RunUAT.bat batch file.

All of the AutomationTool code can be found in the "Programs/Automation" folder of the Solution Explorer.  The 'AutomationScripts.Automation' C# project contains most of the AutomationTool common code including things like "BuildCookRun".  You can set a breakpoint at the 'Execute' function of Automation.cs and that should execute whatever AutomationTool command was given (when it calls "Command.Execute();").  So if you  are adding a new command and AutomationTool isn't finding that command for some reason, this is a good place to start single stepping through code.