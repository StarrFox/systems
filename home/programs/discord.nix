_: {
  programs.nixcord = {
    enable = true;

    discord = {
      vencord.enable = false;
      equicord.enable = true;
      krisp.enable = true;
    };

    config = {
      plugins = {
        fakeNitro = {
          enable = true;
          enableEmojiBypass = false;
          enableStickerBypass = false;
          enableStreamQualityBypass = true;
        };
        favoriteGifSearch = {
          enable = true;
          searchOption = "path";
        };
        betterGifPicker = {
          enable = true;
          keepOpen = true;
        };
        saveFavoriteGifs.enable = true;
        equicordToolbox.enable = true;
        spotifyCrack.enable = true;
        typingTweaks.enable = true;
        typingIndicator.enable = true;
      };
    };
  };
}
