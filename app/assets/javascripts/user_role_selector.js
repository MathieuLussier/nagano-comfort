// const user_role_selector = function() {
//     const UserRoles = { role_user: 'User', role_admin: 'Admin' };
//
//     const url = new URL(window.location.href);
//
//     function checkUserRoleInParams() {
//         if (!url.searchParams.get('user_role')) {
//             setUserRoleInParams('User');
//         }
//     }
//
//     function getRoleByValue(val) {
//         return Object.keys(UserRoles).find(key => UserRoles[key] === val);
//     }
//
//     function setUserRoleInParams(role) {
//         if (url.searchParams.get('user_role')) {
//             url.searchParams.delete('user_role');
//         }
//         url.searchParams.append('user_role', role);
//         window.location.href = url;
//     }
//
//     function onUserRoleChange(event) {
//         event.preventDefault();
//
//         const new_role = UserRoles[event.target.value];
//         setUserRoleInParams(new_role);
//     }
//
//     const selectInput = document.getElementById('user_role');
//
//     if (typeof selectInput === 'undefined' || selectInput == null) {
//         return;
//     }
//
//     checkUserRoleInParams();
//
//     selectInput.value = getRoleByValue(url.searchParams.get('user_role'));
//
//     selectInput.addEventListener('change', onUserRoleChange, false);
// }
//
// window.addEventListener('DOMContentLoaded', user_role_selector);
