require "minitest/autorun"
require_relative "../../src/example.rb"

class SecretTests < Minitest::Test
    def test_init
        e = Example.new
        assert_equal "Hello, world!", e.hw
    end

    def test_rand
        e = Example.new
        assert_equal 4, e.random_digit
    end
end
