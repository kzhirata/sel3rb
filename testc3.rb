require 'selenium-webdriver'
require 'screen-recorder'

#クライアントPCからRemoteWebDriverサーバーにアクセスしテスト実施環境を伝える
driver = Selenium::WebDriver.for :chrome

@recorder = ScreenRecorder::Desktop.new(output: 'recording.mkv')
@recorder.start

#RemoteWebDriverサーバーからサーバー内に存在するGeckoドライバーにアクセスし、Firefoxを起動して以下のURLに遷移する
driver.get('https://www.google.co.jp')
#タイトルを取得しコンソール出力する
puts driver.title
element = driver.find_element( name: 'q')
element.send_keys('シャノン')
element.submit()

@recorder.stop
driver.quit()

@recorder.video
@recorder.video.transcode("recording.mp4") { |progress| puts progress } 
