{ super, ... }:
let user = super.default; in
{
  users.users.${user.username} = {
    openssh = {
      authorizedKeys.keyFiles = [ user.keyFile ];
    };
  };
}
