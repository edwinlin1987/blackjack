class window.ScoresView extends Backbone.View
  className: 'scores'

  template: _.template '<h3> Chips: <%= chips %> </h3> \
                         </br> <h4> Current Bet: <%= bet %> </h4> \
                        </br> <h2><% if(winner === 2){ %>BLACKJACK!<% } \
                         else if(winner === 1){ %>You WIN!<% } \
                         else if (winner === 0){ %>You PUSH!<% } \
                         else if (winner === -1) { %>You LOSE!<% } %></h2>'

  initialize: ->
    @model.on 'change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
