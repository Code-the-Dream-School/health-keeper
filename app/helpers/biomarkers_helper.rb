# frozen_string_literal: true

module BiomarkersHelper
  def format_biomarker_value(range_value, range_unit)
    value_str = if range_unit == 'thousand/cmm'
      range_value.to_i.to_s  # Display WBC values as integers
    else
      format('%<num>0.2f', num: range_value)  # Other values as floats with 2 decimal places
    end
    "#{value_str} #{range_unit}"
  end
end
