class Strings {
  static const appName = 'Jusst Challenge';

  static const systemKey = 'system';
  static const volumeKey = 'volume';
  static const bluetoothKey = 'bluetooth';
  static const playbackKey = 'playback';
  static const playbackPositionKey = 'playbackPosition';
  static const metaDataKey = 'metadata';
  static const titleKey = 'title';
  static const artistKey = 'artist';
  static const coverArtKey = 'coverArt';
  static const durationKey = 'duration';
}

class SystemState {
  static const booting = 'booting';
  static const updating = 'updating';
  static const error = 'error';
  static const ready = 'ready';
}

class PlaybackState {
  static const inactive = 'inactive';
  static const paused = 'paused';
  static const playing = 'playing';
}

class API {
  static const serverHost = 'wss://challenge.jusst.engineering/ws';
}
