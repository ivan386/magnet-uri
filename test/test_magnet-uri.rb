require 'test_helper'
require 'magnet-uri'

class TestMagnetURI < Test::Unit::TestCase

  def test_wikipedia_example_1
    magnet = MagnetURI('magnet:?xt=urn:ed2k:31D6CFE0D16AE931B73C59D7E0C089C0&xl=0&dn=zero_len.fil&xt=urn:bitprint:3I42H3S6NNFQ2MSVX7XZKYAYSCX5QBYJ.LWPNACQDBZRYXW3VHJVCJ64QBZNGHOHHHZWCLNQ&xt=urn:md5:D41D8CD98F00B204E9800998ECF8427E')

    assert_equal 'zero_len.fil', magnet.dn
    assert_equal 0, magnet.xl

    assert magnet.xt.include?('urn:ed2k:31D6CFE0D16AE931B73C59D7E0C089C0')
    assert magnet.xt.include?('urn:bitprint:3I42H3S6NNFQ2MSVX7XZKYAYSCX5QBYJ.LWPNACQDBZRYXW3VHJVCJ64QBZNGHOHHHZWCLNQ')
    assert magnet.xt.include?('urn:md5:D41D8CD98F00B204E9800998ECF8427E')
  end

  def test_wikipedia_example_2
    magnet = MagnetURI('magnet:?xt=urn:ed2k:354B15E68FB8F36D7CD88FF94116CDC1&xl=10826029&dn=mediawiki-1.15.1.tar.gz&xt=urn:tree:tiger:7N5OAMRNGMSSEUE3ORHOKWN4WWIQ5X4EBOOTLJY&xt=urn:btih:QHQXPYWMACKDWKP47RRVIV7VOURXFE5Q&tr=http%3A%2F%2Ftracker.example.org%2Fannounce.php%3Fuk%3D1111111111%26&as=http%3A%2F%2Fdownload.wikimedia.org%2Fmediawiki%2F1.15%2Fmediawiki-1.15.1.tar.gz&xs=http%3A%2F%2Fcache.example.org%2FXRX2PEFXOOEJFRVUCX6HMZMKS5TWG4K5&xs=dchub://example.org')

    assert_equal 'http://download.wikimedia.org/mediawiki/1.15/mediawiki-1.15.1.tar.gz', magnet.as
    assert_equal 'mediawiki-1.15.1.tar.gz', magnet.dn
    assert_equal [], magnet.kt
    assert_equal nil, magnet.mt
    assert_equal ['http://tracker.example.org/announce.php?uk=1111111111'], magnet.tr
    assert_equal 10826029, magnet.xl

    assert magnet.xs.include?('http://cache.example.org/XRX2PEFXOOEJFRVUCX6HMZMKS5TWG4K5')
    assert magnet.xs.include?('dchub://example.org')

    assert magnet.xt.include?('urn:ed2k:354B15E68FB8F36D7CD88FF94116CDC1')
    assert magnet.xt.include?('urn:tree:tiger:7N5OAMRNGMSSEUE3ORHOKWN4WWIQ5X4EBOOTLJY')
    assert magnet.xt.include?('urn:btih:QHQXPYWMACKDWKP47RRVIV7VOURXFE5Q')
  end

  def test_aliased_methods
    magnet = MagnetURI.new('magnet:?xt=urn:ed2k:354B15E68FB8F36D7CD88FF94116CDC1&xl=10826029&dn=mediawiki-1.15.1.tar.gz&xt=urn:tree:tiger:7N5OAMRNGMSSEUE3ORHOKWN4WWIQ5X4EBOOTLJY&xt=urn:btih:QHQXPYWMACKDWKP47RRVIV7VOURXFE5Q&tr=http%3A%2F%2Ftracker.example.org%2Fannounce.php%3Fuk%3D1111111111%26&as=http%3A%2F%2Fdownload.wikimedia.org%2Fmediawiki%2F1.15%2Fmediawiki-1.15.1.tar.gz&xs=http%3A%2F%2Fcache.example.org%2FXRX2PEFXOOEJFRVUCX6HMZMKS5TWG4K5&xs=dchub://example.org')

    assert_equal 'http://download.wikimedia.org/mediawiki/1.15/mediawiki-1.15.1.tar.gz', magnet.acceptable_source
    assert_equal 'mediawiki-1.15.1.tar.gz', magnet.display_name
    assert_equal [], magnet.keywords
    assert_equal nil, magnet.manifest
    assert_equal ['http://tracker.example.org/announce.php?uk=1111111111'], magnet.trackers
    assert_equal 10826029, magnet.length

    assert magnet.source.include?('http://cache.example.org/XRX2PEFXOOEJFRVUCX6HMZMKS5TWG4K5')
    assert magnet.source.include?('dchub://example.org')

    assert magnet.topic.include?('urn:ed2k:354B15E68FB8F36D7CD88FF94116CDC1')
    assert magnet.topic.include?('urn:tree:tiger:7N5OAMRNGMSSEUE3ORHOKWN4WWIQ5X4EBOOTLJY')
    assert magnet.topic.include?('urn:btih:QHQXPYWMACKDWKP47RRVIV7VOURXFE5Q')
  end

  def test_illegal_magnet_uri
    assert_raise(ArgumentError) do
      MagnetURI('magnet:foobar')
    end
  end
end
