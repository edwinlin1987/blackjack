class window.AppView extends Backbone.View

  id: 'board'

  template: _.template '<div class="scores-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>

    <button id="hand-button" class="hand-button">New Hand</button> <input class="hand-button" placeholder="Place your bet here.." id="betInput" type="text"></input>
    <div id="newGame">You ran out of chips! <span id="restart">RESTART!</span></div>'

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click #hand-button': ->
      bet = +@$el.find('#betInput').val();
      if bet > 0 and bet <= @model.get('chips')
        @initialize()
        @model.get('playerHand').showStartingCards()
        @model.get('dealerHand').showDealerCard()
        @$el.find('.score').show()
        @$el.find('.hand-button').attr 'disabled', true
        @$el.find('.hit-button').attr 'disabled', false
        @$el.find('.stand-button').attr 'disabled', false
      else
        alert 'Invalid bet. Try again!'
    'click #restart': ->
      @model.set 'chips', 1000
      @initialize()

  initialize: ->
    @model.get('playerHand') .on 'bust', ->
      @gameEnd()
    , @
    @model.get('dealerHand') .on 'bust', ->
      @gameEnd()
    , @
    @model.get('playerHand') .on 'compare', ->
      @gameEnd()
    , @
    @model.get('dealerHand') .on 'compare', ->
      @gameEnd()
    , @

    bet = 0;
    bet = +@$el.find('#betInput').val();
    @model.set('bet', bet)
    @render()
    @model.get('playerHand').hideStartingCards()
    @model.get('dealerHand').hideStartingCards()
    @$el.find('.score').hide()
    @$el.find('#newGame').hide()
    @$el.find('.hit-button').attr 'disabled', true
    @$el.find('.stand-button').attr 'disabled', true

  gameEnd: ->
    @$el.find('.hit-button').attr 'disabled', true
    @$el.find('.stand-button').attr 'disabled', true
    @$el.find('.hand-button').attr 'disabled', false
    if @model.get('chips') == 0
      @$el.find('#newGame').show()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.scores-container').html new ScoresView(model: @model).el
    @$('.scores-container').prepend('<img id="logo" src="img/blackjack_logo.png"></img>')

