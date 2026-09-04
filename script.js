// Select DOM Elements
const reloadBtn = document.getElementById('btn-reload');
const detailsBtn = document.getElementById('btn-details');
const detailsPane = document.getElementById('details-pane');

// Handle Reload Button Click
if (reloadBtn) {
  reloadBtn.addEventListener('click', () => {
    window.location.reload();
  });
}

// Handle Details Button Toggle
if (detailsBtn && detailsPane) {
  detailsBtn.addEventListener('click', () => {
    const isHidden = detailsPane.classList.contains('hidden');
    
    if (isHidden) {
      detailsPane.classList.remove('hidden');
      detailsBtn.textContent = 'Hide details';
    } else {
      detailsPane.classList.add('hidden');
      detailsBtn.textContent = 'Details';
    }
  });
}
