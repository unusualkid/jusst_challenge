# Jusst_challenge

A Flutter app built for Jusst Engineering's interview for the Mobile Developer role. The app listens to state changes coming from the WebSocket at [wss://challenge.jusst.engineering/ws](wss://challenge.jusst.engineering/ws).

Out of the incoming state events the app shall visualize the following:

### Metadata

- The received Metadata shall be rendered as the applications main view. The coverArt should be the central element. artist and title fields shall be displayed as well, for example below the cover art. Make sure that they are visible, no matter what the devices display size is.

### Volume

- Whenever a volume change event is received, an overlay should be shown for 3 seconds, which displays the new volume.

### Playback state

- The playback state shall be visualized, for example using a play/pause icon, which switches its icon depending on the current state.

### Playback position

- The current playback position shall be made visible. Ideally a progress bar style indicator is made, using the the duration field from the MetaData combined with the current playbackPosition field from the State.

### System state

- In case a non-ready system state is received, show an overlay or notification bar, informing the user about the state. Make the overlay disappear as soon as the system field goes back to ready.

## Getting Started

Open the app in VSCode or an IDE of your choice, and run debug on an iPhone/Android simulator or a mobile device.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
