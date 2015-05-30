class window.AppView extends Backbone.View

  id: 'board'

  template: _.template '<div class="scores-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>

    <button id="hand-button" class="hand-button">New Hand</button> <input class="hand-button" id="betInput" type="text"></input>'

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click #hand-button': ->
      bet = +@$el.find('#betInput').val();
      if bet > 0 and bet <= @model.get('chips')
        @initialize()
        @$el.find('.hand-button').attr 'disabled', true
        @$el.find('.hit-button').attr 'disabled', false
        @$el.find('.stand-button').attr 'disabled', false
      else
        alert 'Invalid bet. Try again!'

  initialize: ->
    @model.get('playerHand') .on 'bust', ->
      @$el.find('.hit-button').attr 'disabled', true
      @$el.find('.stand-button').attr 'disabled', true
      @$el.find('.hand-button').attr 'disabled', false
    , @
    @model.get('dealerHand') .on 'bust', ->
      @$el.find('.hit-button').attr 'disabled', true
      @$el.find('.stand-button').attr 'disabled', true
      @$el.find('.hand-button').attr 'disabled', false
    , @
    @model.get('playerHand') .on 'compare', ->
      @$el.find('.hit-button').attr 'disabled', true
      @$el.find('.stand-button').attr 'disabled', true
      @$el.find('.hand-button').attr 'disabled', false
    , @
    @model.get('dealerHand') .on 'compare', ->
      @$el.find('.hit-button').attr 'disabled', true
      @$el.find('.stand-button').attr 'disabled', true
      @$el.find('.hand-button').attr 'disabled', false
    , @
    if @model.get('chips') == 0
      @model.set 'chips', 1000
      alert 'You suck at blackjack. I\'ll give you another 1000 chips out of pity.'

    bet = 0;
    bet = +@$el.find('#betInput').val();
    @model.set('bet', bet)
    @render()
    @$el.find('.hit-button').attr 'disabled', true
    @$el.find('.stand-button').attr 'disabled', true

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.scores-container').html new ScoresView(model: @model).el
    @$('.scores-container').prepend('<img id="logo" src="img/blackjack_logo.png"></img>')

