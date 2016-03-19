ExpandirJob = Struct.new(:expandido) do

  def perform
    expandido.completar_expansion!
  end

end
