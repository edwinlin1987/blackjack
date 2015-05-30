class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    if @minScore() > 21
      @trigger('bust')

  stand: ->
    if @bestScore() == 21 and @length == 2 then @trigger 'compare' else @trigger 'stand'

  start: ->
    @at(0).flip()
    @hit() while @bestScore() < 17
    @trigger('compare') if @minScore() < 22

  hideStartingCards: ->
    @at(0).set('revealed', false)
    @at(1).set('revealed', false)

  showStartingCards: ->
    @at(0).set('revealed', true)
    @at(1).set('revealed', true)

  showDealerCard: ->
    @at(0).set('revealed', false)
    @at(1).set('revealed', true)

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  bestScore: ->
    if @scores()[1] < 22 then @scores()[1] else @scores()[0]


