{ lib, buildPythonPackage, fetchPypi, isPy3k, aenum, pycryptodomex, requests, simplejson, urllib3 }:

buildPythonPackage rec {
  pname = "bunq_sdk";
  version = "1.10.16";

  disabled = !isPy3k;

  src = fetchPypi {
    inherit pname version;
    sha256 = "1wj4qz6dwhxahkdff9z1fsxalrbk7n1pwzh2sdcbmvy9amdd948p";
  };

  # Strip exact version dependencies from requirements.txt
  patchPhase = ''
    sed -i 's/==\([0-9]\+\.[0-9]\+\)\.[0-9]\+/~=\1/g' bunq_sdk.egg-info/requires.txt setup.py
  '';

  propagatedBuildInputs = [ aenum pycryptodomex requests simplejson urllib3 ];

  meta = with lib; {
    description = "Python SDK for bunq API";
    homepage = https://github.com/bunq/sdk_python;
    license = licenses.mit;
    maintainers = [ maintainers.puckipedia ];
  };
}
