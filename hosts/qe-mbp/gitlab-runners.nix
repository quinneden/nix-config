{ config, pkgs, ... }:
{
  services.gitlab-runner = {
    enable = false;
    extraPackages = with pkgs; [ git ];
    sessionServer.listenAddress = "0.0.0.0:9100";
    services = {
      quinn-mbp = {
        buildsDir = "/var/lib/gitlab-runner/builds";
        registrationConfigFile = "${config.users.users."William.Edenfield".home}/.config/gitlab-runner-reg";
        executor = "shell";
        tagList = [ "quinn-mbp" ];

        environmentVariables = {
          # CARGO_BAZEL_REPIN = "true";
          GIT_STRATEGY = "fetch";
          GIT_DEPTH = "0";
        };

      };
    };
  };

  launchd.daemons.gitlab-runner.serviceConfig = {
    StandardOutPath = "/tmp/gitlab-runner.launchd.out.log";
    StandardErrorPath = "/tmp/gitlab-runner.launchd.err.log";
  };

  users.users.gitlab-runner = {
    name = "gitlab-runner";
    uid = 532;
    gid = config.users.groups.gitlab-runner.gid;
    home = "/var/lib/gitlab-runner";
    shell = "/bin/bash";
    description = "Gitlab agent user";
  };
  users.groups.gitlab-runner = {
    name = "gitlab-runner";
    gid = 532;
    description = "Gitlab agent user group";
  };

  system.activationScripts.preActivation.text =
    let
      name = "gitlab-runner";
      groupPath = "/Groups/${name}";
      userPath = "/Users/${name}";
      user = config.users.users.gitlab-runner;
      group = config.users.groups.gitlab-runner;
      workingDirectory = "/var/lib/${name}";
    in
    ''
      if ! primaryGroupId=$(dscl . -read ${groupPath} 'PrimaryGroupID' 2>/dev/null | cut -d' ' -f2); then
        echo "Creating group ${name}..."
        dscl . -create ${groupPath} 'PrimaryGroupID' ${toString group.gid}
      elif [[ $primaryGroupId -ne ${toString group.gid} ]]; then
        echo "Existing group: ${name} has unexpected GID: $primaryGroupId, expected: ${toString group.gid}" >&2
        exit 1
      fi

      unset 'primaryGroupId'

      # Create user
      if ! uid=$(id -u ${name} 2>/dev/null); then
        echo "Setting up user ${name}..."
        dscl . -create ${userPath}
        dscl . -create ${userPath} 'PrimaryGroupID' ${toString group.gid}
        dscl . -create ${userPath} 'NFSHomeDirectory' ${workingDirectory}
        dscl . -create ${userPath} 'UserShell' /usr/bin/false
        dscl . -create ${userPath} 'IsHidden' 1
        dscl . -create ${userPath} 'UniqueID' ${toString user.uid}
      elif [[ $uid -ne ${toString user.uid} ]]; then
        echo "Existing user: ${name} has unexpected UID: $uid, expected: ${toString user.uid}" >&2
        exit 1
      fi

      unset 'uid'

      # Setup working directory
      if [[ ! -d ${workingDirectory} ]]; then
        echo "Setting up working directory..."
        mkdir -p ${workingDirectory}
      fi

      chown ${name}:${name} ${workingDirectory}
    '';
}
