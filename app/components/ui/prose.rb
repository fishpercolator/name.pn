class Components::UI::Prose < Components::UI::Container
  protected

  def element = :article

  def width = 'prose prose-xl w-full prose-a:text-secondary prose-table:block prose-table:overflow-x-auto prose-table:text-[1em]'
end
