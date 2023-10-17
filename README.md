## Simple CSV parser

Rubyで実装したシンプルなCSVのパーサーです。  
最終的にRubyの標準ライブラリ[csv](https://docs.ruby-lang.org/ja/latest/class/CSV.html:title)`の`CSV.read`を参考に、二次元配列へ変換されます。  

```ruby
CSV.read("sample.csv")
# => [["Ruby", "1995"], ["Rust", "2010"]]
```

**パーサーの出力結果**  

```ruby
f = File.open('csv/simple.csv', 'r')
res = csv_parse(f)
puts "result: #{res}"

# result: [["aaa", "bbb", "ccc"], ["ddd", "eee", "fff"], ["ggg", "hhh", "iii"]]
```

## 対応形式

- 各行の最後にはCRLF(改行)を含む
- 1行目: 必ずヘッダー情報を含む
- 2行目: ヘッダーの項目数と同じ分だけ項目を持つ
- 以降、繰り返し...

[Definition of the CSV Format](https://datatracker.ietf.org/doc/html/rfc4180#section-2)
