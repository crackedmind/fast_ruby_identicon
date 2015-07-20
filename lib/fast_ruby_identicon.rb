require "fast_ruby_identicon/version"
require 'oily_png'
require "ext_fast_ruby_identicon"

module FastRubyIdenticon
  DEFAULT_OPTIONS = {
    border_size: 35,
    square_size: 50,
    grid_size: 7,
    background_color: ChunkyPNG::Color::TRANSPARENT,
    key: "\x00\x11\x22\x33\x44\x55\x66\x77\x88\x99\xAA\xBB\xCC\xDD\xEE\xFF"
  }
# create an identicon png and save it to the given filename
  #
  # Example:
  #   >> RubyIdenticon.create_and_save('identicons are great!', 'test_identicon.png')
  #   => result (Boolean)
  #
  # @param title [string] the string value to be represented as an identicon
  # @param filename [string] the full path and filename to save the identicon png to
  # @param options [hash] additional options for the identicon
  #
  def self.create_and_save(title, filename, options = {})
    raise 'filename cannot be nil' if filename == nil

    blob = create(title, options)
    return false if blob == nil

    File.open(filename, 'wb') { |f| f.write(blob) }
  end

  # create an identicon png and return it as a binary string
  #
  # Example:
  #   >> RubyIdenticon.create('identicons are great!')
  #   => binary blob (String)
  #
  # @param title [string] the string value to be represented as an identicon
  # @param options [hash] additional options for the identicon
  #
  def self.create(title, options = {})
    options = DEFAULT_OPTIONS.merge(options)

    raise 'title cannot be nil' if title == nil
    raise 'key is nil or less than 16 bytes' if options[:key] == nil || options[:key].length < 16
    raise 'grid_size must be between 4 and 9' if options[:grid_size] < 4 || options[:grid_size] > 9
    raise 'invalid border size' if options[:border_size] < 0
    raise 'invalid square size' if options[:square_size] < 0

    hash = SipHash.digest(title)

    png = ChunkyPNG::Image.new((options[:border_size] * 2) + (options[:square_size] * options[:grid_size]),
     (options[:border_size] * 2) + (options[:square_size] * options[:grid_size]), options[:background_color])

    # set the foreground color by using the first three bytes of the hash value
    color = ChunkyPNG::Color.rgba((hash & 0xff), ((hash >> 8) & 0xff), ((hash >> 16) & 0xff), 0xff)

    # remove the first three bytes that were used for the foreground color
    hash >>= 24

    sqx = sqy = 0
    (options[:grid_size] * ((options[:grid_size] + 1) / 2)).times do
      if hash & 1 == 1
        x = options[:border_size] + (sqx * options[:square_size])
        y = options[:border_size] + (sqy * options[:square_size])

        # left hand side
        png.rect(x, y, x + options[:square_size], y + options[:square_size], color, color)

        # mirror right hand side
       x = options[:border_size] + ((options[:grid_size] - 1 - sqx) * options[:square_size])
       png.rect(x, y, x + options[:square_size], y + options[:square_size], color, color)
      end

      hash >>= 1
      sqy += 1
      if sqy == options[:grid_size]
        sqy = 0
        sqx += 1
      end
    end

    png.to_blob color_mode: ChunkyPNG::COLOR_INDEXED
  end
end
