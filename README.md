# JWT Vala Library

A Native Vala Minimal JWT Library
## Build Requirements

- Vala

## Usage

```
using JWT;

class demo {

  public static int main(string[] args) {
    string key = "secret";
    string payload = "{\"sub\":\"1234567890\",\"name\":\"John Doe\",\"admin\":true}";
    string header = "{\"alg\":\"HS256\",\"typ\":\"JWT\"}";

    var jwt = new Jwt();
    stdout.printf(jwt.encode(header, payload, key));
    return 0;
  }

}
```

## Build Instructions

valac JWT/jwt.vala demo.vala -o demo

## Demo

The demo application is pre-configures with a plaintext secret `secret`

```
✗ valac JWT/jwt.vala demo.vala -o demo
✗ ./demo
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ
```

Validate with [JWT.io](https://jwt.io)
