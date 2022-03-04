class Corrector
  def correct_name(name)
    name.strip.capitalize.slice(0..9)
  end
end
