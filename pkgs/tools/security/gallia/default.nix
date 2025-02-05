{ lib
, fetchFromGitHub
, python3
, cacert
}:

python3.pkgs.buildPythonApplication rec {
  pname = "gallia";
  version = "1.3.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "Fraunhofer-AISEC";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-ofGAeTPEvzFTswDSR2xdlF5qxE41xsNeOB0G4xbHJYo=";
  };

  pythonRelaxDeps = [
    "aiofiles"
    "argcomplete"
    "msgspec"
  ];

  nativeBuildInputs = with python3.pkgs; [
    poetry-core
    pythonRelaxDepsHook
  ];

  propagatedBuildInputs = with python3.pkgs; [
    aiofiles
    aiohttp
    aiosqlite
    argcomplete
    can
    construct
    exitcode
    msgspec
    platformdirs
    pydantic
    pygit2
    tabulate
    tomli
    zstandard
  ];

  SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";

  nativeCheckInputs = with python3.pkgs; [
    pytestCheckHook
    pytest-asyncio
  ];

  pythonImportsCheck = [
    "gallia"
  ];

  preCheck = ''
    export PATH=$out/bin:$PATH
  '';

  meta = with lib; {
    description = "Extendable Pentesting Framework for the Automotive Domain";
    homepage = "https://github.com/Fraunhofer-AISEC/gallia";
    changelog = "https://github.com/Fraunhofer-AISEC/gallia/releases/tag/v${version}";
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ fab rumpelsepp ];
    platforms = platforms.linux;
  };
}
