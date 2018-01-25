# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# template = (item) -> item.text
#
# jQuery(document).on ->
#   $('#search').select2
#     ajax: {
#       url: '/contracts/search'
#       data: (params) ->
#         {
#           search: params.term
#         }
#       dataType: 'json'
#       delay: 500
#       processResults:  (data, params) ->
#         {
#             results: _.map(data,(el)
#             {
#               id: el.id
#               text: "#{el.company_name} (#{el.website})}"
#             }
#             )
#         }
#       cache: true
#     }
#     escapeMarkup: (markup) -> markup
#     minimumInputLength: 2
#     templateResult: template
#     templateSelection: template
#     theme: 'bootstrap'
