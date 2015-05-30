assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null
  dealerHand = null
  game = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    dealerHand = deck.dealDealer()

  describe 'Game Start', ->
    it 'Player hand should have two cards', ->
      assert.strictEqual hand.length, 2

    it 'Dealer hand should have two cards', ->
      assert.strictEqual dealerHand.length, 2

    it 'Deck should have dealt two hands out', ->
      assert.strictEqual deck.length, 48

  describe 'Game Play', ->
    it 'Player should get another card if hits', ->
      hand.hit()
      assert.strictEqual hand.length, 3



