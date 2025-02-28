{ ... }: {
  accounts.email.accounts.catboy = {
    primary = true;
    userName = "catboy009";
    realName = "catboy";
    address = "catboy009@icloud.com";
    passwordCommand = "cat /var/secrets/mail";
    imap = {
      host = "imap.mail.me.com";
      port = 993;
    };
    smtp = {
      host = "smtp.mail.me.com";
      port = 587;
      tls.useStartTls = true;
    };
    himalaya.enable = true;
  };
  programs.himalaya.enable = true;
}
