{ lib }:

let
  mkValueString =
    v:
    if v == null then
      ""
    else if builtins.isBool v then
      lib.boolToString v
    else if builtins.isInt v then
      builtins.toString v
    else if builtins.isFloat v then
      lib.strings.floatToString v
    # Convert lists of strings like `["foo" "bar"]` into space-separated strings like `foo bar`
    else if builtins.isList v then
      let
        ensureStrings =
          ls:
          lib.forEach ls (
            item:
            if builtins.isString item then
              item
            else
              throw "Expected all list items to be strings but got ${builtins.typeOf item} instead"
          );
      in
      lib.concatStringsSep " " (ensureStrings v)
    else if lib.isDerivation v then
      builtins.toString v
    else if builtins.isPath v then
      builtins.toString v
    else if builtins.isAttrs v then
      builtins.toJSON v
    else if builtins.isString v then
      v
    else if lib.strings.isCoercibleToString v then
      builtins.toString v
    else
      abort "The Nix configuration value ${lib.generators.toPretty { } v} can't be encoded";

  mkKeyValue = k: v: "${lib.escape [ "=" ] k} = ${mkValueString v}";
in

{
  mkCustomConfig = attrs: lib.mapAttrsToList mkKeyValue attrs;
}
