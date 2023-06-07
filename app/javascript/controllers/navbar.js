const toggleBtn = document.getElementById('toggleBtn');
const navbarContent = document.getElementById('navbarSupportedContent');

// Add an event listener to the toggle button
toggleBtn.addEventListener('click', () => {
  // Toggle the "show" class on navbar content
  navbarContent.classList.toggle('show');
});