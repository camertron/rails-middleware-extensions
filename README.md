## rails-middleware-extensions [![Build Status](https://secure.travis-ci.org/camertron/rails-middleware-extensions.png?branch=master)](http://travis-ci.org/camertron/rails-middleware-extensions)

A Ruby version of Python's binascii module.

## Installation

`gem install binascii`

## Usage

```ruby
require 'binascii'
```

### Base64

Encodes and decodes text in the base64 format. This differs from Ruby's built-in base64 encoding mechanism in that it removes line breaks from the result and provides the option to append a newline character at the end.

```ruby
Binascii.b2a_base64('abc')                  # => "YWJj\n"
Binascii.b2a_base64('abc', newline: false)  # => "YWJj"

Binascii.a2b_base64('YWJj')    # => "abc"
Binascii.a2b_base64("YWJj\n")  # => "abc"
```

### CRC32

This is simply a wrapper around the CRC32 functionality present in Ruby's `Zlib` module.

```ruby
Binascii.crc32('abc')  # => 891568578
```

### Hexlify

Outputs each byte of the input data as two hexadecimal characters. Produces a string that contains twice as many bytes as the input data.

```ruby
# aliased as .hexlify
Binascii.b2a_hex('jkl')  # => "6a6b6c"

# aliased as .unhexlify
Binascii.a2b_hex('6a6b6c')  # => "jkl"
```

### HQX and Run-length Encoding

Encodes and decodes bytes in the HQX format. HQX is (apparently) often combined with RLE, or run-length encoding.

```ruby
rle = Binascii.rlecode_hqx('aaaaabbbbbb')            # => "a\x90\x05b\x90\x06"
hqx = Binascii.b2a_hqx(rle)                          # => # => "BC!&BT!'"

Binascii.rledecode_hqx(Binascii.a2b_hqx(hqx).first)  # => "aaaaabbbbbb"
```

`.a2b_hqx` returns an array with two elements. The first is the decoded result, and the second is an integer containing either 1 or 0. 1 indicates decoding was stopped because of the presence of a stop character (ASCII code 58, i.e. a colon, ':'), 0 means no stop character was found.

### Quoted-printable

Encodes and decodes bytes in the quoted-printable format.

```ruby
Binascii.b2a_qp("some \x12 \x14 data")  # => "some =12 =14 data"
Binascii.a2b_qp('some =12 =14 data')    # => "some \x12 \x14 data"
```

### Unix-to-unix

Encodes and decodes bytes in the unix-to-unix format.

```ruby
Binascii.b2a_uu("abc\n")         # => "$86)C\"@  \n"
Binascii.a2b_uu("$86)C\"@  \n")  # => "abc\n"
```

## Running Benchmarks

Benchmarks are provided for most of Binascii's functionality in the bench/ directory. Run each benchmark directly, i.e. `bundle exec ruby bench/hqx_bench.rb`. Binascii's algorithms are compared to native Ruby versions when they are available. However it should be noted that, with the exception of CRC32, all algorithms implemented by this library will not produce exactly the same output as their Ruby counterparts as they accept generally more options and therefore produce more customizable output. It should also be noted that the Ruby equivalents are all implemented in C and will therefore be much faster in most cases.

## Running Tests

`bundle exec rspec` should do the trick :)

## License

Licensed under the MIT license. See LICENSE for details.

## Authors

* Cameron C. Dutro: http://github.com/camertron
