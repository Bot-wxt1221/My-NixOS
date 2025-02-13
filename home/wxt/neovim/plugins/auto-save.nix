{
  programs.nixvim.plugins.auto-save = {
    enable = true;
    settings = {
      debounce_delay = 250;
      trigger_events.defer_save = [ "InsertLeave" ];
      trigger_events.cancel_deferred_save = [ "InsertEnter" ];
      trigger_events.immediate_save = [ ];
    };
  };
}
