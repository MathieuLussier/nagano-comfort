//
// /**
//  *  FormController class will take a form element and handle backend request and response.
//  *
//  *  @param {HTMLElement} el - Element to handle
//  * */
// const FormController = function(el) {
//     if (!el instanceof HTMLElement)
//         throw new Error('[FormController] Element need to be instance of HTMLElement');
//     if (el.tagName !== 'FORM')
//         throw new Error('[FormController] Element need to be a form tag');
//
//     this.el = el;
//     this.init();
// }
//
// FormController.prototype.init = function() {
//     this.el.addEventListener('submit', this.submitHandler.bind(this), false);
// }
//
// FormController.prototype.prepareFormData = function() {
//     const formData = new FormData(this.el);
//     const pairs = [];
//
//     for (let key of formData.keys()) {
//         const value = formData.get(key);
//         pairs.push(`${encodeURIComponent(key)}=${encodeURIComponent(value)}`);
//     }
//
//     return pairs.join('&').replace(/%20/g, '+');
// }
//
// FormController.prototype.get = async function(url, data = {}) {
//     const res = await fetch(url, {
//         method: 'GET',
//         headers: {
//             'Accept': 'application/json'
//         }
//     });
//
//     return { res, data: await res.json() };
// }
//
// FormController.prototype.post = async function(url, data = {}) {
//     const res = await fetch(url, {
//         method: 'POST',
//         headers: {
//             'Accept': 'application/json',
//             'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
//         },
//         body: data
//     });
//
//     return { res, data: await res.json() };
// }
//
// FormController.prototype.submitHandler = async function(event) {
//     event.preventDefault();
//     const form = event.target;
//     const data = this.prepareFormData();
//     const url = form.getAttribute('action');
//     const method = this[form.getAttribute('method').toLowerCase()];
//
//     try {
//         const req = await method(url, data);
//
//         console.log(req.data);
//
//         if (!req.res.ok && req.res.status >= 500)
//             throw new Error(req.statusText);
//
//         if (!req.res.ok) {
//             for (let msg of req.data) {
//                 alert(msg, 'danger', 0);
//             }
//             return;
//         }
//
//         alert('Success', 'success');
//     } catch (e) {
//         console.error(e);
//         alert(e || 'Unknown error happened', 'danger');
//     }
// }
//
// const initializeFormController = function() {
//     const formElements = document.querySelectorAll("form[data-async='true']");
//     for (let el of formElements) { new FormController(el) }
// }
//
// window.addEventListener('load', initializeFormController);
