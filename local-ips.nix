{lib, ...}: let
  # {name: value} -> {value: [name]}
  into_hosts = set: builtins.listToAttrs (builtins.map (entry: {name = entry.value; value = [entry.name];}) (lib.attrsToList set));
in rec {
  ips = {
    nixarr = "192.168.122.189";
    nixtest = "192.168.122.214";
    nixtop = "192.168.1.110";
    starrnix = "192.168.1.71";
  };

  as_hosts = into_hosts ips;
}