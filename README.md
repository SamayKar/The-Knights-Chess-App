# Multiplayer Chess Game

A completely Responsive Multiplayer Chess Game - Works on Android, iOS, Web & Desktop! 

## Features
- Create/Join Room
- Play Realtime
- Only Valid moves possible and invalid moves wont be moved
- All rules of Chess are followed
- Cross Platform Game


## Installation
After cloning this repository, migrate to ```chess_final_final``` folder.

Install dependencies (Client Side)
```bash
flutter pub get
```

Install dependencies (Server Side)

```bash
cd server && npm install
```

Start the server

```bash
npm run dev
```

Configure for MacOS:
Head to macos/Runner and make sure the following keys are present in DebugProfile.entitlements and Release.entitlements
```bash
<key>com.apple.security.network.server</key>
<true/>
<key>com.apple.security.network.client</key>
<true/>
```

Run App
```bash
flutter run // After selecting the device you want to test on
```

## Tech Used
**Server**: Node.js, Express, Socket.io, Mongoose, MongoDB

**Client**: Flutter, Provider


