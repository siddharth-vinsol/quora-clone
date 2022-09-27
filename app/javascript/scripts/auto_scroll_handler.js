class AutoScrollHandler {
  constructor(scrollToElement) {
    this.scrollToElement = scrollToElement
  }

  init() {
    if (this.scrollToElement) {
      $('html, body').animate({ scrollTop: this.scrollToElement.offset().top }, 1000);
      this.scrollToElement.addClass('highlight')
      this.scrollToElement.animate({backgroundColor: '#000000'}, 'slow');
    }
  }
}

const urlParams = new URLSearchParams(window.location.search);
if (urlParams.has('scroll_to')) {
  const elementId = urlParams.get('scroll_to')
  let autoScrollHandler = new AutoScrollHandler($(`*[data-scroll_id="${elementId}"]`))
  autoScrollHandler.init();
}
