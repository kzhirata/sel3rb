require 'selenium-webdriver'
require 'screen-recorder'

#クライアントPCからRemoteWebDriverサーバーにアクセスしテスト実施環境を伝える
driver = Selenium::WebDriver.for :firefox

@recorder = ScreenRecorder::Desktop.new(output: 'recording.mkv')
@recorder.start

#RemoteWebDriverサーバーからサーバー内に存在するGeckoドライバーにアクセスし、Firefoxを起動して以下のURLに遷移する
driver.get('https://www.google.co.jp')
#タイトルを取得しコンソール出力する
puts driver.title
element = driver.find_element( name: 'q')
element.send_keys('シャノン')
element.submit()
sleep 5
driver.quit()

@recorder.stop
@recorder.video
@recorder.video.transcode("recording.mp4") { |progress| puts progress } 
