{
  description = ''github api'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-github-2_0_4.flake = false;
  inputs.src-github-2_0_4.ref   = "refs/tags/2.0.4";
  inputs.src-github-2_0_4.owner = "disruptek";
  inputs.src-github-2_0_4.repo  = "github";
  inputs.src-github-2_0_4.type  = "github";
  
  inputs."npeg".owner = "nim-nix-pkgs";
  inputs."npeg".ref   = "master";
  inputs."npeg".repo  = "npeg";
  inputs."npeg".dir   = "0_26_0";
  inputs."npeg".type  = "github";
  inputs."npeg".inputs.nixpkgs.follows = "nixpkgs";
  inputs."npeg".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."github.com/disruptek/rest".owner = "nim-nix-pkgs";
  inputs."github.com/disruptek/rest".ref   = "master";
  inputs."github.com/disruptek/rest".repo  = "github.com/disruptek/rest";
  inputs."github.com/disruptek/rest".dir   = "";
  inputs."github.com/disruptek/rest".type  = "github";
  inputs."github.com/disruptek/rest".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/disruptek/rest".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-github-2_0_4"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-github-2_0_4";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}