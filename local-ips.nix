{ lib, ... }:
let
  # {name: value} -> {value: [name]}
  into_hosts =
    set:
    builtins.listToAttrs (
      builtins.map (entry: {
        name = entry.value;
        value = [ entry.name ];
      }) (lib.attrsToList set)
    );
in
rec {
  ips = {
    nixarr = "192.168.122.39";
    nixtest = "192.168.122.214";
    nixtop = "192.168.1.110";
    nixmain = "192.168.4.20";
    nixcell = "192.168.4.29";
  };

  as_hosts = into_hosts ips;
}
