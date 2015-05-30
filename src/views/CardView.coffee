class window.CardView extends Backbone.View
  className: 'card'

  # template: _.template '<%= rankName %> of <%= suitName %>'
  tagName: 'img'

  initialize: -> @render()

  # render: ->
  #   @$el.children().detach()
  #   @$el.html @template @model.attributes
  #   @$el.addClass 'covered' unless @model.get 'revealed'

  render: ->
    @$el.children().detach()
    @$el.attr('src', 'img/cards/'+ @model.get('rankName') + '-' + @model.get('suitName') + '.png')
    @$el.attr('src', 'img/card-back.png') unless @model.get 'revealed'

