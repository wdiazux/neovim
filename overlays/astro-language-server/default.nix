{ channels, ... }:

final: prev: {
  inherit (channels.unstable) astro-language-server;
}
