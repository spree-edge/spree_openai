document.addEventListener("turbo:load", function() {

  // Listen for click on translate link
  document.querySelectorAll('.translate-link').forEach(link => {
    link.addEventListener('click', function(event) {
      event.preventDefault();
      const field = event.target.dataset.field;
      translateField(field);
    });
  });

  // Function to translate the field
  function translateField(field) {
    const englishContent = document.querySelector(`input[name="translation[${field}][en]"]`).value;

    const localesElement = document.getElementById('locales');
    const localesData = localesElement.getAttribute('data-locales');

    const locales = JSON.parse(localesData);

    fetchTranslation(englishContent, locales, field);
  }

  // Function to fetch translation from API
  function fetchTranslation(content, locales, field) {
    const params = new URLSearchParams({
      content: content,
      locales: locales,
      field: field
    });

    fetch('/admin/translate', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      body: params
    })
    .then(response => response.json())
    .then(data => {
      updateFields(data);
    })
    .catch(error => console.error('Error:', error));
  }

  // Function to update fields with translated content
  function updateFields(data) {
    const translations = data.translations;
    const locales = Object.keys(translations);
    const field = data.field;

    locales.forEach(locale => {
      const value = translations[locale];
      document.querySelector(`input[name="translation[${field}][${locale}]"]`).value = value;
    });
  }
});
