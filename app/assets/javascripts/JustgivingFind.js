$(document).ready(function() {
  $('body').delegate('.search-results', 'click', function(me) {
    $(document).find('#competition_justgiving_id').val($(this).data().id);
  });
  // $('body').delegate('#justgiving-find', 'click', function(me) {
  $('#justgiving-find').click(function() {
    event.preventDefault();
    $.ajax({
      dataType: 'json',
      url: 'https://api-sandbox.justgiving.com/c9a8f1e9/v1/charity/search',
      data: { q: $('#justgiving-search-text').val(),
              pageSize: 100 },
      // headers: { 'x-api-key': 'c9a8f1e9' },
      success: function(data) {
        var overMax = '';
        if (data.numberOfHits > 100) {
          overMax = 'Showing the first 100. ';
        }
        $(document).find('#search-feedback')
          .replaceWith('<div id="search-feedback" class="no-errors"></div>');
        $(document).find('#search-feedback')
          .html('<p>' + data.numberOfHits +
            ' results found. ' + overMax + 'Click to select.</p>');
          $(document).find('#search-results').html('');
          for (var i=0; i<data.numberOfHits; i++) {
            $(document).find('#search-results').
              append('<p class="search-results" data-id="' +
              data.charitySearchResults[i].charityId + '" data-dismiss="modal">' +
              data.charitySearchResults[i].name + ' : ' +
              data.charitySearchResults[i].charityId + '</p>');
          }
      },
      error: function(data) {
        if (data.status == 404) {
          $(document).find('#search-feedback')
            .replaceWith('<div id="search-feedback" class="error">No results found!</div>');
          $(document).find('#search-results').html('');
        }
      }
    });
  });
});
// $(document).on('page:load', ready);
//  http://stackoverflow.com/questions/18770517/rails-4-how-to-use-document-ready-with-turbo-links