class window.AppView extends Backbone.View
  template: _.template '
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @model.get('playerHand') .on 'bust', ->
      @initialize()
    , @
    @model.get('dealerHand') .on 'bust', ->
      @initialize()
    , @
    @model.get('playerHand') .on 'compare', ->
      @initialize()
    , @
    @model.get('dealerHand') .on 'compare', ->
      @initialize()
    , @
    if @model.get('chips') == 0
      @model.set 'chips', 1000
      alert 'You suck at blackjack. I\'ll give you another 1000 chips out of pity.'

    bet = -1
    bet = +prompt('You have ' + @model.get('chips') + 'chips. How much do you want to bet?') while bet <= 0 or bet > @model.get('chips')
    @model.set('bet', bet)
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el

