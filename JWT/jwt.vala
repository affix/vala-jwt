/**
* Copyright 2019 Keiran Smith <opensource@keiran.scot>
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is furnished
* to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
*  copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

namespace JWT {
  class Jwt {

    public static string base64urlencode(uint8[] input) {
      return Base64.encode(input).replace("=","")
                                 .replace("+","-")
                                 .replace("/","_");
    }

    public static uint8[] HS256(uint8[] key, uint8[] data) {
      ChecksumType type = ChecksumType.SHA256;
      int block_size = 64;

      uint8[] buffer = key;
      if (key.length > block_size) {
          buffer = Checksum.compute_for_data(type, key).data;
      }
      buffer.resize(block_size);

      Checksum inner = new Checksum(type);
      Checksum outer = new Checksum(type);

      uint8[] padding = new uint8[block_size];
      for (int i=0; i < block_size; i++) {
          padding[i] = 0x36 ^ buffer[i];
      }
      inner.update(padding, padding.length);
      for (int i=0; i < block_size; i++) {
          padding[i] = 0x5c ^ buffer[i];
      }
      outer.update(padding, padding.length);

      size_t length = buffer.length;
      inner.update(data, data.length);
      inner.get_digest(buffer, ref length);

      outer.update(buffer, length);

      uint8[] signature = new uint8[length];
      outer.get_digest(signature, ref length);

      return signature;
    }

    public string encode(string header, string payload, string key) {
      string data = base64urlencode(header.data) + "." + base64urlencode(payload.data);
      var checksum = HS256(key.data, data.data);

      return data + "." + base64urlencode(checksum);
    }

  }
}
