# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'chips', 1000
    @set 'bet', 0
    @set 'winner', undefined
    @set 'best', 1000
    @get('deck').on 'remove', ->
      if @get('deck').length <= 0
        alert "Out of cards... Shuffling the Deck!"
        @get('deck').initialize()
    , @
    @listen()

  listen: ->
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @get('playerHand').on 'stand', ->
      @get('dealerHand').start()
    , @
    @get('playerHand') .on 'bust', ->
      #alert "You Lose!"
      @set 'winner', -1
      @set 'chips', @get('chips') - @get('bet')
      @listen()
    , @
    @get('dealerHand') .on 'bust', ->
      #alert "You Win!"
      @set 'winner', 1
      @set 'chips', @get('chips') + @get('bet')
      @set 'best', @get('chips') if @get('chips') > @get 'best'
      @listen()
    , @
    @get('playerHand') .on 'compare', ->
      #alert "BLACKJACK!"
      @set 'winner', 2
      @set 'chips', @get('chips') + 1.5*@get('bet')
      @set 'best', @get('chips') if @get('chips') > @get 'best'
      @listen()
    , @
    @get('dealerHand') .on 'compare', ->
      ph = @get('playerHand').bestScore()
      dh = @get('dealerHand').bestScore()
      if ph > dh
        #alert "You Win!"
        @set 'winner', 1
        @set 'chips', @get('chips') + @get('bet')
        @set 'best', @get('chips') if @get('chips') > @get 'best'
      else if ph == dh
        #alert "You Push!"
        @set 'winner', 0
      else
        #alert "You Lose!"
        @set 'winner', -1
        @set 'chips', @get('chips') - @get('bet')
      @listen()
    , @


