{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "zoraxy";
  version = "3.0.7";
  src = fetchFromGitHub {
    owner = "tobychui";
    repo = "zoraxy";
    rev = "refs/tags/${version}";
    sha256 = "sha256-fyhnP+MtX5dYR9yzIp7vpahJKbkuvopZSSTwt7JnaMI=";
  };

  sourceRoot = "${src.name}/src";

  vendorHash = "sha256-FiE7j2XB6QcJBu1wtTpBCkfi0ac8pzx6RSOcVrsaOwQ=";

  checkFlags =
    let
      # Skip tests that require network access
      skippedTests = [
        "TestExtractIssuerNameFromPEM"
        "TestReplaceLocationHost"
        "TestReplaceLocationHostRelative"
        "TestHandleTraceRoute"
        "TestHandlePing"
      ];
    in
    [ "-skip=^${builtins.concatStringsSep "$|^" skippedTests}$" ];

  meta = {
    description = "General purpose HTTP reverse proxy and forwarding tool written in Go";
    homepage = "https://zoraxy.arozos.com/";
    changelog = "https://github.com/tobychui/zoraxy/blob/v${version}/CHANGELOG.md";
    license = lib.licenses.agpl3Only;
    maintainers = [ lib.maintainers.luftmensch-luftmensch ];
    mainProgram = "zoraxy";
  };
}
