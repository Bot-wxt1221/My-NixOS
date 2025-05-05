{
  pkgs,
  lib,
  ...
}:

{
  programs.thunderbird = {
    package = pkgs.thunderbird-latest;
    enable = true;
    profiles.admin = {
      isDefault = true;
      userChrome = "";
      userContent = "";
      withExternalGnupg = true;
      settings = {
        "calendar.timezone.useSystemTimezone" = true;
        "datareporting.healthreport.uploadEnabled" = false;
        "extensions.ui.locale.hidden" = true;
        "extensions.webextensions.ExtensionStorageIDB.migrated.addon@darkreader.org" = true;
        "extensions.webextensions.uuids" = lib.generators.toJSON { } {
          "default-theme@mozilla.org" = "5787f490-29b8-436e-a111-640da8590790";
          "google@search.mozilla.org" = "cc340383-7068-4b32-a10f-9f19334bfebc";
        };
        "mail.account.lastKey" = 5;
        "mail.close_message_window.on_delete.disabled" = false;
        "mail.e2ee.auto_enable" = true;
        "mail.imap.chunk_size" = 106496;
        "mail.imap.min_chunk_size_threshold" = 159744;
        "mail.mdn.report.enabled" = false;
        "mail.openMessageBehavior.version" = 1;
        "mail.pane_config.dynamic" = 2;
        "mail.purge_threshhold_mb" = 20;
        "mail.purge_threshold_migrated" = true;
        "mail.spam.manualMark" = true;
        "mail.spam.version" = 1;
        "mail.startup.enabledMailCheckOnce" = true;
        "mailnews.mark_message_read.delay" = true;
        "mailnews.mark_message_read.delay.interval" = 3;
        "mailnews.tags.$label1.color" = "#FF0000";
        "mailnews.tags.$label1.tag" = "Important";
        "mailnews.tags.$label2.color" = "#FF9900";
        "mailnews.tags.$label2.tag" = "Work";
        "mailnews.tags.$label3.color" = "#009900";
        "mailnews.tags.$label3.tag" = "Personal";
        "mailnews.tags.$label4.color" = "#3333FF";
        "mailnews.tags.$label4.tag" = "To Do";
        "mailnews.tags.$label5.color" = "#993399";
        "mailnews.tags.$label5.tag" = "Later";
        "pdfjs.enabledCache.state" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.purge_trackers.date_in_cookie_database" = "0";
      };
    };
  };
}
