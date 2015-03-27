God.watch do |w|
  w.name = 'pay_viewers'
  w.start = 'rake tb:pay_viewers'
  w.dir = File.dirname(__FILE__).split('/')[0..-3].join('/')
  w.log = '/tmp/oreo.txt'
  w.keepalive
end
