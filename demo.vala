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
