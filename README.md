# ios-android-webview-bridge-sample
iOS + Android WebView bridge Sample

Start to run localhost
```
cd WebApp
yarn start
```

### iOS Setup Tips for localhost

add below to Info.plist

```
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

### Android Setup Tips for localhost

add below to AndroidManifest.xml

```
<uses-permission android:name="android.permission.INTERNET" />

<application
        android:usesCleartextTraffic="true"
        ...
        >
```
