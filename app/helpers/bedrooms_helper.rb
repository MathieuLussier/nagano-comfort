module BedroomsHelper
  def card_bedroom(bedroom)
    @bedroom = bedroom
    render partial: 'shared/bedrooms/card', bedroom: @bedroom
  end
end
