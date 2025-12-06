{ config, pkgs, lib, ... }:
{
  options = with lib; with types; {
    shisa = mkOption { type = str; };
    metaton = mkOption { type = str; };
    test = mkOption { type = str; };
  };
  config = {
      shisa = 	"#5fd7ff";
      metaton =	"#ffdf5f";
      test =  	"#875faf";
  };
}
