# frozen_string_literal: true

require_relative 'parser'

def assert(result, expect)
  if result == expect
    [:pass, result, expect]
  else
    [:fail, result, expect]
  end
end

def it(label, &block)
  raise 'Block is required' unless block_given?

  status, result, expect = yield block
  if status == :pass
    puts "[OK] #{label}"
  else
    puts "[FAIL] #{label} (result=#{result}, expect=#{expect})"
  end
end

it 'simple.csv' do
  f = File.open('csv/simple.csv', 'r')
  result = csv_parse(f)
  expect = [
    ['aaa', 'bbb', 'ccc'],
    ['ddd', 'eee', 'fff'],
    ['ggg', 'hhh', 'iii'],
  ]

  assert(result, expect)
end

it 'empty.csv' do
  f = File.open('csv/empty.csv', 'r')
  result = csv_parse(f)
  expect = []

  assert(result, expect)
end
