
document.addEventListener('DOMContentLoaded', () => {
  const searchInput = document.querySelector('#search-input');

  if (searchInput) {
    searchInput.addEventListener('input', () => {
      const query = searchInput.value;

      fetch(`/events?query=${query}`, {
        headers: {
          'Accept': 'application/json',
        },
      })
      .then(response => response.json())
      .then(events => {
        console.log('seevents ', events)
        const eventsList = document.querySelector('.events-list');
        eventsList.innerHTML = '';

        events.forEach(event => {
          const eventElement = document.createElement('div');
          eventElement.classList.add('event');
          eventElement.innerHTML = `
            <h3><a href="/events/${event.id}">${event.name}</a></h3>
            <p>Artist: ${event.artist}</p>
            <p>Producer: ${event.producer}</p>
            <p>Date: ${event.date}</p>
            <p>Location: ${event.location}</p>
          `;
          eventsList.appendChild(eventElement);
        });
      });
    });
  }
});
