class Views::Layouts::Profile < Views::Layouts::Base
  def view_template(&)
    document('min-h-screen bg-fixed bg-linear-[180.3deg,#ddd_5.5%,#6e88a1_90.2%]') { main(&) }
  end
end
