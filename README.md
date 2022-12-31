# requestcamaccess
Example on how to create a bundle requesting camera access from a Java app in Eclipse


How to make a Java App on macos requesting Camera and Microphone Access
Posted on 26. Dezember 2022 by admin	

Since Catalina it is required to request permissions for camera and microphone usages.

A useful tool for resetting access rights is tccutil.

Reset e.g. the camera access rights for Terminal app:

$ tccutil reset Camera com.apple.Terminal
Successfully reset Camera approval status for com.apple.Terminal

Or reset the camera access rights for all apps at once:

$ tccutil reset Camera
Successfully reset Camera

But you can’t grant access rights by this tool.

There are two ways to get your IDE to have access to the camera, or microphone.

First is to start it from the Terminal app.

When starting your Java app using the camera from the IDE, it will give you a prompt to accept/decline the camera usage.
Access Prompt

For the second approach you need an Apple developer account which is not for free.

You need to entitle the JDK, or the IDE for camera usage.

[See here for an example using the JDK.](https://github.com/sarxos/webcam-capture/issues/723#issuecomment-606714970)

For eclipse go to the /Applications folder and open Eclipse.app folder by right clicking and selecting „Show package contents“.
Package structure

Open Info.plist and add this key:

<key>NSCameraUsageDescription</key>
<string>This app requires Camera usage.</string>

The string will be shown in the request for access later.
Access Prompt

In Contents/MacOS folder create the entitlements.plist containing:

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>com.apple.security.cs.allow-jit</key>
    <true/>
    <key>com.apple.security.cs.allow-unsigned-executable-memory</key>
    <true/>
    <key>com.apple.security.cs.disable-library-validation</key>
    <true/>
    <key>com.apple.security.cs.allow-dyld-environment-variables</key>
    <true/>
    <key>com.apple.security.cs.debugger</key>
    <true/>
    <key>com.apple.security.device.camera</key>
    <true/>
</dict>
</plist>

Now re-sign the app in a terminal at /Applications/Eclipse.app/Contents/macOS location with

codesign -s "Developer" --force --deep --options runtime --entitlements entitlements.plist /Applications/Eclipse.app

So for development, you can now run a Java App that is using the camera from the IDE.
But how to entitle your app in production?

You will need to create an app bundle including an Info.plist file and a dylib requesting access in native code.

The Info.plist file has to include the Privacy - Camera Usage Description property.
Example of an Info.plist with Privacy - Camera Usage Description property

When I started investigating, I came about [this post on stackoverflow.com](https://stackoverflow.com/questions/27628385/write-call-swift-code-using-java-s-jni), explaining how to build a dylib that uses swing code.

I modified the example to have convenient file names and changed the swing code to check and request access to the camera.

From here I included the two dylibs into my apps jarfile und used [native-utils](https://github.com/adamheinrich/native-utils) to load them.

You can find a demo app here.

