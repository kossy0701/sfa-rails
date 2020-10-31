require 'prawn'

class InvoicePdfExporter
  # 使用するフォントのパスを定数化
  FONT_PATH = Rails.root + 'public/fonts/ipaexm.ttf'

  def initialize
    # Prawnドキュメントを生成
    # ページサイズはマージンを指定
    Prawn::Document.generate(Rails.root + '請求書.pdf', page_size: 'A4', top_margin: 35, bottom_margin: 35, left_margin: 35, right_margin: 35) do |pdf|

      # フォントを指定しないと Prawn::Errors::IncompatibleStringEncoding 例外が発生する
      pdf.font FONT_PATH

      # 本文の生成
      # もっと責務の分割をしてもいいと思う
      self.draw_content pdf
    end
  end

  def draw_content(doc)
    # bunding_boxメソッドでボックスを生成
    # 引数にはボックス生成位置、横、縦のサイズを指定
    doc.bounding_box([50, 750], width: 300, height: 150) do

      # textメソッドでテキストを挿入。引数には文字サイズとalignを指定できる。:left, :right, :center
      doc.text "〒163-8001", size: 10, align: :left

      # move_downメソッドで次のテキストの書き出し位置を下げている
      doc.move_down 10
      doc.text "東京都新宿区西新宿2丁目8−1", size: 10, align: :left

      doc.move_down 10
      doc.text "ご担当者 様", size: 12, align: :left
    end

    doc.bounding_box([300, 750], width: 300, height: 150) do
      doc.text 'HogeHoge株式会社', size: 12, align: :left
      doc.move_down 5
      doc.text '〒103-0021', size: 10, align: :left
      doc.move_down 5
      doc.text '東京都中央区日本橋本石町2-1-1', size: 10, align: :left
      doc.move_down 5
      doc.text '本店ビル4F 経理部経理課', size: 10, align: :left
      doc.move_down 5
      doc.text 'TEL: 03-1234-5678', size: 10, align: :left
    end

    doc.text '請求書', size: 20, align: :center

    doc.bounding_box([0, 550], width: 300, height: 60) do
      doc.text '下記の通りご請求申し上げます。', size: 10, align: :left
      doc.move_down 10
      doc.text "合計金額 57,267円", size: 16, align: :left
    end

    doc.bounding_box([320, 550], width: 300, height: 60) do
      doc.text "日付　　　　　：　　　2020年10月01日", size: 10, align: :left
    end

    rows = [['雑費', '1', '56700', '56700']]

    # tableメソッドでテーブルを生成する
    # rowsは多重配列を指定している
    # 多重配列でない場合 Prawn::Errors::InvalidTableData 例外が発生する
    doc.table rows.unshift(['詳細', '数量', '単価', '金額']), column_widths: [370, 30, 60, 60], position: :center do |table|
      # セルのサイズの指定
      table.cells.size = 10

      # 1行目のalignを真ん中寄せにしている
      table.row(0).align = :center
    end

    doc.bounding_box([0, 300], width: 300, height: 100) do
      doc.text "振込期限　　　2020年10月31日", size: 10, align: :left
      doc.move_down 10
      doc.text '振込先　　　　日本銀行 本店 0000', size: 10, align: :left
      doc.move_down 10
      doc.text '　　　　　　　普通：　1234567', size: 10, align: :left
    end

    doc.bounding_box([373, 300], width: 150, height: 100) do
      doc.table [['小計', "56700円"], ['消費税', "567円"], ['合計金額', "57267円"]], column_widths: [50, 100], position: :right do |table|
        table.cells.size = 10
      end
    end
  end
end
