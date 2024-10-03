$(document).ready(function() {

    $('#search-input').on('input', function() {
        let query = $(this).val();
        $.get(`/api/papers`, { q: query }, function(data) {
            let resultsHtml = '';
            data.forEach(function(paper) {
                resultsHtml += `
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="card-title">${paper.title}</h5>
                            <h6 class="card-subtitle mb-2 text-muted">${paper.author}</h6>
                            <button class="btn btn-primary btn-sm view-paper" data-id="${paper.id}">View</button>
                        </div>
                    </div>
                `;
            });
            $('#results').html(resultsHtml);
        }).fail(function(jqXHR, textStatus, errorThrown) {
            console.error('Error:', textStatus, errorThrown);  // Log any errors
        });
    });

    $(document).on('click', '.view-paper', function() {
        let id = $(this).data('id');
        $.get(`/api/paper/${id}`, function(paper) {
            $('#results').html(`
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${paper.title}</h5>
                        <h6 class="card-subtitle mb-2 text-muted">${paper.author}</h6>
                        <p class="card-text">${paper.content}</p>
                        <button class="btn btn-secondary btn-sm" id="back-button">Back to Search</button>
                    </div>
                </div>
            `);
        });
    });

    $(document).on('click', '#back-button', function() {
        $('#search-input').val('').trigger('input');
    });
});