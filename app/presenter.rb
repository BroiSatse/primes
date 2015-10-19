class Presenter
  PADDING = 1

  def initialize table
    @table = table
  end

  def column_widths
    return @column_widths if @column_widths
    @column_widths = {
      header: get_max_width(@table.values),
      data: @table.table.transpose.map {|column| get_max_width column }
    }
  end

  def cell(text, size)
    text.to_s.rjust(size) + ' ' * PADDING
  end

  def border
    '|' + ' ' * PADDING
  end

  def row(header, values)
    result = ''
    result << cell(header, column_widths[:header])
    result << border
    values.each_with_index do |value, index|
      result << cell(value, column_widths[:data][index])
    end
    result
  end

  def vertical_line
    result = '-' * (column_widths[:header] + PADDING)
    result << '+'
    result << '-' * column_widths[:data].inject(0) {|sum, width| sum + width + PADDING }
    result
  end

  def to_s
    lines = []
    lines << row('', @table.values)
    lines << vertical_line
    lines += @table.values.zip(@table.table).map {|header, values| row(header, values)}
    lines.join("\n")
  end

  private

  def get_max_width(objects)
    objects.map {|o| o.to_s.length }.max
  end
end