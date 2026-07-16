{
  ...
}:
{
  perSystem =
    {
      pkgs,
      lib,
      ...
    }:
    {
      packages.resharper-pkg = pkgs.buildDotnetGlobalTool {
        pname = "resharper-cli";
        version = "2026.1.3";
        nugetName = "JetBrains.ReSharper.GlobalTools";
        executables = [ "jb" ];

        nugetHash = "sha256-rpS2+NAwul94ubUv0nAFpK9ogFnbqSF19DaLRli1R8c=";

        meta = {
          description = "JetBrains ReSharper command-line tools (CleanupCode, InspectCode, etc.)";
          homepage = "https://www.jetbrains.com/resharper/";
          maintainers = [ lib.maintainers.khaneliman ];
          mainProgram = "jb";
        };
      };
    };
}
