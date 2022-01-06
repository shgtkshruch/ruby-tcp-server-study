require 'socket'
require_relative './mock/mock'

PORT = 1234
ENDPOINT='0.0.0.0'

# Socket::AF_INET: => 2
# IPv4 で通信する

# Socket::SOCK_STREAM => 1
# ストリーム型の通信（TCP）
# https://e-words.jp/w/%E3%82%B3%E3%83%8D%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3%E5%9E%8B%E9%80%9A%E4%BF%A1.html

# ソケットを生成する
# https://ja.wikipedia.org/wiki/%E3%82%BD%E3%82%B1%E3%83%83%E3%83%88_(BSD)
# server = Socket.new(2, 1) と書いても動く
server = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM)

p "Server Start Port: #{PORT}"

# サーバーのポート番号やドメインを元に、
# 接続情報を表すソケットアドレス構造体という文字列を生成する
# "\x10\x02\x04\xD3\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00
sockaddr = Socket.sockaddr_in(PORT, ENDPOINT)

# ソケットを sockaddr に結合する
server.bind(sockaddr)

# ソケットで接続を待ち受ける
server.listen(5)

loop do
  connection, addr_info = server.accept

  print 'Local address: '
  p connection.local_address

  print 'Remote address: '
  p connection.remote_address

  Mock.call(connection)
end
