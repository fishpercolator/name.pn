class Views::Layouts::Page < Views::Layouts::Application
  private

  def page(&) = article(class: 'prose prose-xl mx-auto w-full px-4 py-12 prose-a:text-secondary prose-table:block prose-table:overflow-x-auto prose-table:text-[1em]', &)
end
