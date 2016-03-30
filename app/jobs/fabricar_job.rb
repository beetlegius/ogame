FabricarJob = Struct.new(:fabricante_id, :fabricante_type, :tipo, :cantidad_restante) do

  def perform
    fabricado.completar_fabricacion! cantidad_restante
  end

  def fabricante
    @fabricante ||= fabricante_type.constantize.find fabricante_id
  end

  def fabricado
    @fabricado ||= fabricante.send(tipo)
  end

  def to_partial_path
    'jobs/fabricar_job'
  end

end
