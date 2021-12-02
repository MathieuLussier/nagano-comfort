// const limit_pagination_selector = function() {
//     const url = new URL(window.location.href);
//
//     function onLimitPaginationChange(event) {
//         event.preventDefault();
//
//         url.searchParams.set('limit', event.target.value);
//         url.searchParams.set('pages', 0);
//         window.location.href = url;
//     }
//
//     const selectInput = document.getElementById('limit-pagination');
//
//     if (typeof selectInput === 'undefined' || selectInput == null) {
//         return;
//     }
//
//     selectInput.value = url.searchParams.get('limit') || 10;
//
//     selectInput.addEventListener('change', onLimitPaginationChange, false);
// }
//
// window.addEventListener('DOMContentLoaded', limit_pagination_selector);
