class Components::Daisy::Field < Components::Base
  def initialize(builder, attribute, **attributes)
    @builder = builder
    @attribute = attribute
    @attributes = attributes
  end

  private

  def error? = @builder.object&.errors&.include?(@attribute)
end
