{...}: {
  services.mako = {
    enable = true;
    settings = {
      max-history = 3;
      background-color = "#282a36";
      text-color = "#f8f8f2";
      border-color = "#ff79c6";
      default-timeout = 10000;
    };
  };
}
