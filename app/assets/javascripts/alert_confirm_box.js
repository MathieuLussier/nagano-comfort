window.alert = function(message, type = 'primary', duration = 3000) {
    const el = document.createElement('div');
    el.className = `alert alert-${type} alert-dismissible fade show`;
    el.setAttribute('role', 'alert');
    el.innerHTML = `
        <span>${message}</span>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    `;
    const alert = new bootstrap.Alert(el);
    document.body.prepend(alert._element);
    if (duration > 0) {
        setTimeout(() => {
            alert.close();
        }, duration);
    }
}

$.rails.allowAction = (link) => {
    if (!link[0].hasAttribute('data-confirm'))
        return true
    createConfirmModal(link).show();
    return false;
}

$.rails.confirm = (link) => {
    link[0].removeAttribute('data-confirm');
    link[0].click();
}

function createConfirmModal(link) {
    const message = link[0].dataset.confirm;
    const el = document.createElement('div');
    el.className = 'modal';
    el.setAttribute('tabindex', '-1');
    el.innerHTML = `
        <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title">${message}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary confirm-button" data-bs-dismiss="modal">Confirm</button>
              </div>
            </div>
      </div>
    `;
    el.querySelector('.confirm-button').addEventListener('click', (event) => {
       event.preventDefault();
       $.rails.confirm(link);
    });
    return new bootstrap.Modal(el);
}
