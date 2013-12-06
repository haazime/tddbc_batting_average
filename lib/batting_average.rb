module BattingAverage
  extend self

  def calculate(appearance: appearance, bat: bat, hit: hit)
    return nil if appearance == 0
    return "0.000" if bat == 0
    "%.3f" % (hit.to_f / bat.to_f)
  end
end
