{
  username = "andre";
  timezone = "America/Sao_Paulo";
  language = "en_US.UTF-8";
  locale = "pt_BR.UTF-8";
  hostname = "nixos";
  git = {
    user = "andre-brandao";
    email = "82166576+andre-brandao@users.noreply.github.com";
  };
  configDir = "/home/andre/dotfiles/nixos";
  allowUnfree = [
    "spotify"
    "steam-unwrapped"
    "steam"
    "discord"
    "obsidian"
    "vault-bin"
    "vault"
    "idea"
    "minecraft-server"
    "unrar"
  ];

  sshPublicKeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCuQkJ02xZKVFiulDUVgtyOzR01L9aj0ydfivlJtuip81NqsfPhwWW4XyW6uLkkhmOsDUsr9ZhEzl4XsLRX2r8PZS03/XBLH/7Yft6P01ECxyCe9vnXZ8i8J3FJ141ZLQPXtNTqpRmPdPYbclDQASqnVu5UKfaBlWyheXni9R0bvPC1FqpozUh4+UVUMJT4dUkThSX+Ph5/czJAZkwzwsKrOn0A99qwX1wmFewh3UJ4QOpYgjE8QTyVdEUnDFdiB2vybrRjWD9kqROQslVG2CtYU+P2aDvLJa2Rdau/mTOyWM+Vn9a/dM55tDuwwD/VJWw97/f2f0YYXs+29OhTZXPKLRLGTURhQgOK6afX6x7EUsPJp+7n2D38FSqskgh4RxU7nf+Ja7YLsqaJCNdLj9yfvOBvBZdHpsf7yykSX9Fdkl9Dqrgg9e6HRmWK4cEULq5JObWyKnizHJEMXCJeGTWO3Z3hxh6fw6c84a6AD2PvckPxpUZpza2grNez+EonBuq0YKgARhv9ZpqOVoKJ6W9Xg7PYZRAOMsAgWFasLZQxgJtne7U4d/Tlp6xWeDr9DbTdqFTm+tsQEYynOb3EG3BsAdTrRunx5xrYPmtk4FYTC+ru6zBpq9yGwafhjwjd1G2YR3z6MToOUykC/veLi9L0uJKeHtw12qaEzs3ETn382Q== root@pve"

    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMieINuQUpTfgeZpfUYTpSO27FNJ/rMq08uxGKjW5Mv0 andre-brandao@github/98560022 # ssh-import-id gh:andre-brandao"
  ];
}
