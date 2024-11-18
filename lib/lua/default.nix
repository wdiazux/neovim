{ lib, ... }:
let
  inherit (builtins)
    hasAttr
    head
    throw
    typeOf
    isList
    isAttrs
    isBool
    isInt
    isString
    isPath
    isFloat
    toJSON
    ;
  inherit (lib.attrsets) mapAttrsToList filterAttrs;
  inherit (lib.strings)
    concatStringsSep
    concatMapStringsSep
    stringToCharacters
    ;
  inherit (lib.trivial) boolToString warn;
in
rec {
  lua = {
    mkRaw = value: { __raw = value; };
  };

  isLuaInline = object: (object._type or null) == "lua-inline";

  toLuaObject =
    args:
    if isAttrs args then
      if isLuaInline args then
        args.expr
      else if hasAttr "__empty" args then
        warn ''
          Using `__empty` to define an empty lua table is deprecated. Use an empty attrset instead.
        '' "{ }"
      else
        "{"
        + (concatStringsSep "," (
          mapAttrsToList (
            n: v:
            if head (stringToCharacters n) == "@" then
              toLuaObject v
            else
              "[${toLuaObject n}] = " + (toLuaObject v)
          ) (filterAttrs (_: v: v != null) args)
        ))
        + "}"
    else if isList args then
      "{" + concatMapStringsSep "," toLuaObject args + "}"
    else if isString args then
      toJSON args
    else if isPath args then
      toJSON (toString args)
    else if isBool args then
      "${boolToString args}"
    else if isFloat args then
      "${toString args}"
    else if isInt args then
      "${toString args}"
    else if (args == null) then
      "nil"
    else
      throw "could not convert object of type `${typeOf args}` to lua object";
}
