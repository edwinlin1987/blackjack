# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'chips', 1000
    @set 'bet', 0
    @get('deck').on 'remove', ->
      if @get('deck').length <= 0
        alert "Out of cards... Starting a new game!"
        @get('deck').reset(null)
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
      alert "You Lose!"
      @set 'chips', @get('chips') - @get('bet')
      @listen()
    , @
    @get('dealerHand') .on 'bust', ->
      alert "You Win!"
      @set 'chips', @get('chips') + @get('bet')
      @listen()
    , @
    @get('dealerHand') .on 'compare', ->
      ph = @get('playerHand').bestScore()
      dh = @get('dealerHand').bestScore()
      if ph > dh
        alert "You Win!"
        @set 'chips', @get('chips') + @get('bet')
      else if ph == dh
        alert "You Push!"
      else
        alert "You Lose!"
        @set 'chips', @get('chips') - @get('bet')
      @listen()
    , @


