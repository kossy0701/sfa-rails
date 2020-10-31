require 'rexml/document'

class CreateXml

  def initialize
    # 雛形オブジェクトの作成
    @doc = REXML::Document.new

    # 宣言要素の記述
    @doc << REXML::XMLDecl.new('1.1', 'UTF-8')

    # 要素の追加
    # add_element 要素名, 要素の属性
    # xmlns属性は名前空間を宣言するための属性
    # https://www.mitsue.co.jp/glossary/html4_xhtml1/attribute/xmlns.html
    @report_el = @doc.add_element 'Report', {
      'xmlns' => 'http://xml.kishou.go.jp/jmaxml1/',
      'xmlns:jmx' => 'http://xml.kishou.go.jp/jmaxml1/'
    }
  end

  def create_xml
    insert_control_part
    insert_head_part

    File.open(Rails.root + 'output.xml', 'w') do |file|
      # ファイル書き出し
      # インデントは2を指定
      @doc.write(file, indent=2)
    end
  end

  private

  def insert_control_part
    control_el = @report_el.add_element 'Control'

    title_el = control_el.add_element 'Title'

    # テキストの挿入
    title_el.add_text '季節観測'

    date_time_el = control_el.add_element 'DateTime'
    date_time_el.add_text '2009-01-09T02:02:05Z'

    status_el = control_el.add_element 'Status'
    status_el.add_text '通常'

    editor_office_el = control_el.add_element 'EditorialOffice'
    editor_office_el.add_text '熊谷地方気象台'

    publish_office_el = control_el.add_element 'PublishingOffice'
    publish_office_el.add_text '熊谷地方気象台'
  end

  def insert_head_part
    head_el = @report_el.add_element 'Head', {
      'xmlns' => 'http://xml.kishou.go.jp/jmaxml1/informationBasis1/'
    }

    title_el = head_el.add_element 'Title'
    title_el.add_text '季節観測'

    report_date_time_el = head_el.add_element 'ReportDateTime'
    report_date_time_el.add_text '2009-01-09T11:00:00+09:00'

    target_date_time = head_el.add_element 'TargetDateTime'
    target_date_time.add_text '2009-01-09T00:00:00+09:00'

    event_id_el = head_el.add_element 'EventID'
    event_id_el.add_text '20090109110000_初雪'

    info_type_id = head_el.add_element 'InfoType'
    info_type_id.add_text '発表'

    head_el.add_element 'Serial'

    info_kind_id = head_el.add_element 'InfoKind'
    info_type_id.add_text '特殊気象報'

    info_kind_version_el = head_el.add_element 'InfoKindVersion'
    info_kind_version_el.add_text '1.0_0'

    head_line_el = head_el.add_element 'Headline'
    head_el.add_element 'Text'
  end
end
