# frozen_string_literal: true

Token = Struct.new('Token', :kind, :value, :next)

def tokenize(file)
  head = Token.new(:start, '', nil)
  cur_token = head

  until file.eof?
    value = file.getc
    token = case value
            when ','
              Token.new(:comma, ',', nil)
            when "\n"
              Token.new(:crlf, "\n", nil)
            else
              Token.new(:value, value, nil)
            end
    cur_token.next = token
    cur_token = token
  end

  head.next
end

def token2csv(token)
  cur_token = token
  rows = []
  row = []

  until cur_token.nil?
    case cur_token.kind
    when :comma
      cur_token = cur_token.next
    when :crlf
      rows.push(row)
      row = []
      cur_token = cur_token.next
    when :value
      value = ''
      while cur_token.kind == :value
        value += cur_token.value
        cur_token = cur_token.next
      end
      row.push(value)
    end
  end

  rows
end

def csv_parse(file)
  token = tokenize(file)
  token2csv(token)
end

require 'csv'
require 'benchmark'

Benchmark.bm do |x|
  x.report('標準ライブラリ:CSV.read') do
    CSV.read('csv/simple.csv')
  end
  x.report('自作パーサー:csv_parse') do
    f = File.open('csv/simple.csv', 'r')
    csv_parse(f)
  end
end
